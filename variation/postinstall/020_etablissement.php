<?php
/*
This file is part of Variation.

Variation is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Variation is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Variation.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------
Ce fichier fait partie de Variation.

Variation est un logiciel libre ; vous pouvez le redistribuer ou le modifier 
suivant les termes de la GNU Affero General Public License telle que publiée 
par la Free Software Foundation ; soit la version 3 de la licence, soit 
(à votre gré) toute version ultérieure.

Variation est distribué dans l'espoir qu'il sera utile, 
mais SANS AUCUNE GARANTIE ; sans même la garantie tacite de 
QUALITÉ MARCHANDE ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la 
GNU Affero General Public License pour plus de détails.

Vous devez avoir reçu une copie de la GNU Affero General Public License 
en même temps que Variation ; si ce n'est pas le cas, 
consultez <http://www.gnu.org/licenses>.
--------------------------------------------------------------------------------
Copyright (c) 2014 Kavarna SARL
*/
?>
<?php

if ($argc < 3) { 
  usage();
  exit;
}
$arrangement = $argv[2];

require ('../inc/config.inc.php');
require ('../inc/common.inc.php');
require ('../inc/pgprocedures.class.php');
$base = new PgProcedures ($pghost, $pguser, $pgpass, $pgbase);
$base->startTransaction ();

$uti_infos = $base->utilisateur_login2 ('variation', $argv[1]);
if (!count ($uti_infos)) {
  usage();
  exit;
}
$uti_id_variation = $uti_infos[0]['uti_id'];
$token = $uti_infos[0]['tok_token'];

$filename = $arrangement.'/arrangement/etablissement.csv';
// Convertit le fichier en UTF-8
$contenu = file_get_contents_detect ($filename);
$tempfile = tempnam(sys_get_temp_dir(), '');
file_put_contents ($tempfile, $contenu);

$f = fopen ($tempfile, 'r');

$ligne = fgetcsv ($f, 0, "\t");
$cat_nom = $ligne[1];

$ligne = fgetcsv ($f, 0, "\t");
$eta_nom = $ligne[1];

$ligne = fgetcsv ($f, 0, "\t");
$codes_secteurs = explode(',', $ligne[1]);

/* Ajout d'une catégorie */
$cat_id = $base->meta_categorie_add ($token, $cat_nom, $base->pour_code ($cat_nom));

/* Ajout d'un établissement */
$eta_id = $base->etablissement_add ($token, $eta_nom, $cat_id,
				    NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/* Affectation de l'établissement aux secteurs */
$base->etablissement_secteurs_set ($token, $eta_id, $codes_secteurs);

/* Création des groupes de l'établissement définis dans le fichier */
fgetcsv($f, 0, "\t");
while ( ($ligne = fgetcsv($f, 0, "\t")) !== FALSE) {
  $nom_groupe = array_shift($ligne);
  $grp_id = $base->groupe_add ($token, $nom_groupe, $eta_id, NULL, NULL, NULL);
  $codes_secteurs = array ();
  foreach ($ligne as $temp) {
    list($code_secteur, $code_info) = explode(',', $temp);
    $codes_secteurs[] = $code_secteur;
    $inf = $base->meta_info_get_par_code ($token, $code_info);
    if ($inf['inf_id']) {
      $base->groupe_info_secteur_save ($token, $grp_id, $code_secteur, $inf['inf_id']);
    }
  }
  $base->groupe_secteurs_set ($token, $grp_id, $codes_secteurs);
}

$base->commit ();

function usage () {
  global $argv;
  echo "Usage: $argv[0] 'mot de passe variation'\n";
}
?>

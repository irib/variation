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
Copyright (c) 2015 Kavarna SARL
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

/* On récupère quelques infos génériques */
$pors = $base->meta_portail_liste ($token, null);
$por_ids = array ();
if (is_array ($pors)) {
  foreach ($pors as $por) {
    $por_ids[] = $por['por_id'];
  }
}

$themes = $base->notes_theme_liste_details($token, NULL);
if (is_array ($themes)) {
  foreach ($themes as $theme) {
    $base->notes_theme_update ($token, $theme['the_id'], $theme['the_nom'], $por_ids);
  }
}
$base->commit ();

function usage () {
  global $argv;
  echo "Usage: $argv[0] 'mot de passe variation'\n";
}
?>

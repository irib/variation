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
/* Prérequis :
 - au moins un établissement
 - au moins un portail
*/
$gut_nom = "Administrateur système";
$uti_nom = 'Administrateur';
$uti_prenom = 'Système';
$uti_login = 'admin';
$uti_passwd = 'admin';
$grp_date_debut = date('d/m/Y');

if ($argc < 3) { 
  usage();
  exit;
}
$arrangement = $argv[2];

require ('../inc/config.inc.php');
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

/* Établissement */
$etas = $base->etablissement_liste ($token, true, null);
$eta_id = $etas[0]['eta_id'];

/* Portails */
$pors = $base->meta_portail_liste ($token, null);
$por_ids = array ();
if (is_array($pors)) {
  foreach ($pors as $por) {
    $por_ids[] = $por['por_id'];
  }
}

// Recherche des groupes de prise en charge
$sec_prise_en_charge = $base->meta_secteur_get_par_code($token, 'prise_en_charge');
$grps = $base->groupe_liste_details($token, $eta_id, $sec_prise_en_charge['sec_id'],
				    null, true);
$grp_ids = array ();
if (is_array($grps)) {
  foreach ($grps as $grp) {
    $grp_ids[] = $grp['grp_id'];
  }
}

/* Ajout de groupes */
/* portail * tous groupes de prise en charge */
if (is_array($pors)) {
  foreach ($pors as $por) {
    $nom = $por['por_libelle'];
    $gut_id = $base->login_grouputil_add ($token, $nom);
    $base->login_grouputil_groupe_set ($token, $gut_id, $grp_ids);
    $base->login_grouputil_portail_set ($token, $gut_id, array($por['por_id']));  
  }
}

/* portail * groupe de prise en charge */
if (is_array($pors) && is_array($grps)) {
  foreach ($pors as $por) {    
    foreach ($grps as $grp) {
      $nom = $por['por_libelle'].' '.$grp['grp_nom'];
      $gut_id = $base->login_grouputil_add ($token, $nom);
      $base->login_grouputil_groupe_set ($token, $gut_id, array($grp['grp_id']));
      $base->login_grouputil_portail_set ($token, $gut_id, array($por['por_id']));  
    }
  }
}

/* Ajout d'un groupe d'utilisateurs */
$gut_id = $base->login_grouputil_add ($token, $gut_nom);
$base->login_grouputil_groupe_set ($token, $gut_id, $grp_ids);
$base->login_grouputil_portail_set ($token, $gut_id, $por_ids);

/* Ajout d'un employé */
$per_id = $base->personne_ajoute ($token, 'personnel');
$base->personne_info_varchar_set ($token, $per_id, 'nom', $uti_nom, $uti_id_variation);
$base->personne_info_varchar_set ($token, $per_id, 'prenom', $uti_prenom, $uti_id_variation);

/* Ajout d'un utilisateur "admin" */
$uti_id = $base->utilisateur_add ($token, $uti_login, $per_id, TRUE, TRUE, '');
$base->utilisateur_grouputil_set ($token, $uti_id, array ($gut_id));

/* Connexion avec admin pour changer le mot de passe */
$uti = $base->utilisateur_get ($token, $uti_id);
$uti_infos_admin = $base->utilisateur_login2 ($uti_login, $uti['uti_pwd']);
$token_admin = $uti_infos_admin[0]['tok_token'];
$base->utilisateur_mdp_change ($token_admin, $uti_passwd);

$base->commit ();
function usage () {
  global $argv;
  echo "Usage: $argv[0] 'mot de passe variation'\n";
}
?>

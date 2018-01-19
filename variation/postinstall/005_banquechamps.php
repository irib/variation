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

$infos_types = $base->meta_infos_type_liste ($token);
$int_id = array ();
foreach ($infos_types as $infos_type) {
  $int_id[$infos_type['int_code']] = $infos_type['int_id'];
}


$filename = $arrangement.'/arrangement/banquechamps.xml';
$xml = simplexml_load_file ($filename);
$xml_selections = $xml->selections->selection;
if (count($xml_selections)) {
  foreach ($xml_selections as $xml_selection) {
    $sel_id = $base->meta_selection_add($token, 
					(string)$xml_selection->code, 
					(string)$xml_selection->libelle, 
					(string)$xml_selection->info);
    $xml_entrees = $xml_selection->entrees->entree;
    if (count ($xml_entrees)) {
      $ordre = 0;
      foreach ($xml_entrees as $xml_entree) {
	$base->meta_selection_entree_add($token, $sel_id, (string)$xml_entree, $ordre++);
      }
    }
  }
}

import_dirinfos ($xml, null);

function import_dirinfos ($xml_parent, $din_id_parent) {
  global $base, $token, $int_id;
  $xml_dirinfos = $xml_parent->dirinfo;
  if (count ($xml_dirinfos)) {
    foreach ($xml_dirinfos as $xml_dirinfo) {
      $din_id = $base->meta_dirinfo_add($token, $din_id_parent, (string)$xml_dirinfo->libelle);
      import_dirinfos ($xml_dirinfo, $din_id);
      $xml_infos = $xml_dirinfo->infos->info;
      if (count ($xml_infos)) {
	foreach ($xml_infos as $xml_info) {
	  $inf_id = $base->meta_info_add($token, 
					 $int_id[(string)$xml_info->int_code],
					 (string)$xml_info->code,
					 (string)$xml_info->libelle,
					 (string)$xml_info->libelle_complet,
					 $xml_info->etendu == 1,
					 $xml_info->historique == 1,
					 $xml_info->multiple == 1);

	  $base->meta_info_move($token, $inf_id, $din_id);
	  $base->meta_info_aide_set($token, $inf_id, (string)$xml_info->aide);

	  switch ($xml_info->int_code) {
	  case 'date':
	    $base->meta_infos_date_update ($token,
					   $inf_id,
					   $xml_info->date_echeance == 1,
					   $xml_info->date_echeance_icone,
					   $xml_info->date_echeance_secteur
					   );
	    break;
	  case 'textelong':
	    $base->meta_infos_textelong_update ($token,
						$inf_id,
						$xml_info->textelong_nblignes);
	    break;
	  case 'selection':
	    $sel = $base->meta_selection_infos_par_code($token, (string)$xml_info->selection_code);
	    $base->meta_infos_selection_update ($token,
						$inf_id,
						$sel['sel_id']);
	    break;
	  case 'groupe':
	    $base->meta_infos_groupe_update ($token,
					     $inf_id,
					     $xml_info->groupe_type,
					     $xml_info->groupe_soustype);
	    break;
	  case 'contact':
	    $base->meta_infos_contact_update ($token,
					      $inf_id, 
					      $xml_info->contact_filtre,
					      $xml_info->contact_secteur
					      );
	    break;
	  case 'metier':
	    $base->meta_infos_metier_update ($token,
					     $inf_id,
					     $xml_info->metier_secteur);
	    break;
	  case 'etablissement':
	    $base->meta_infos_etablissement_update ($token,
						    $inf_id,
						    $xml_info->etablissement_interne == 1,
						    $xml_info->etablissement_secteur
						    );
	    break;
	  case 'date_calcule':
	  case 'coche_calcule':
	    $base->meta_infos_formule_update ($token,
					      $inf_id,
					      $xml_info->formule                                   
					      );
	    break;
	  }

	}
      }
    }
  }
}

$base->commit ();

function usage () {
  global $argv;
  echo "Usage: $argv[0] 'mot de passe variation'\n";
}

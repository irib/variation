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

/* On récupère quelques infos génériques */
$entites = $base->meta_entite_liste ($token);
foreach ($entites as $entite) {
  $ent[$entite['ent_code']] = $entite;
}

$filenames = glob ($arrangement.'/arrangement/portail*.csv');
if (is_array($filenames)) {
  foreach ($filenames as $filename) {
    // Convertit le fichier en UTF-8
    $contenu = file_get_contents_detect ($filename);
    $tempfile = tempnam(sys_get_temp_dir(), '');
    file_put_contents ($tempfile, $contenu);
    $f = fopen ($tempfile, 'r');
    
    // On sélectionne la première catégorie
    $cats = $base->meta_categorie_liste ($token);
    $cat = $cats[0];
    
    /**
     * ent_id de la fenêtre personne en cours
     * ou -1 pour fenêtre principale
     * ou NULL si dans aucune fenêtre (problème)
     */
    $ent_id_courant = null;
    
    $tom_id_courant = null;
    $tsm_id_courant = null;
    
    $men_id_courant = null;
    $sme_id_courant = null;
    $gin_id_courant = null;
    
    while ( ($ligne = fgetcsv ($f, 0, "\t")) !== FALSE) {
      $objname = $ligne[0];
      
      // Ligne commentaire
      if (substr ($objname, 0, 1) == '#')
	continue;

      switch ($objname) {
      
      case 'portail':
	$nom = $ligne[1];
	$por_id = $base->meta_portail_add ($token, $cat['cat_id'], $nom); 
	if (count($ligne) > 2) {
	  foreach (array('usager', 'personnel', 'contact', 'famille') as $k => $v) {
	    $base->droit_ajout_entite_portail_set ($token, $v, $por_id, isset($ligne[$k+2]) && $ligne[$k+2] == '1');
	  }
	  $base->droit_portail_set($token, $por_id, 'suppression_notes', isset($ligne[6]) && $ligne[6] == '1');

	} else {
	  $base->droit_portail_set($token, $por_id, 'suppression_notes', true);
	}
	break;
      
      case 'fenetre':
	$ent_code = $ligne[1];
	if ($ent_code == 'principale') {
	  // Fenêtre principale
	  $ent_id_courant = -1;
	} else {
	  // Fenêtre personne
	  $ent_id_courant = isset ($ent[$ent_code]) ? $ent[$ent_code]['ent_id'] : null;
	}
	break;

      case 'menu':
	$nom = $ligne[1];
	if ($ent_id_courant == null) {
	  echo "ERREUR : Dans aucune fenêtre\n";
	  $base->rollback ();
	  exit;
	} else if ($ent_id_courant == -1) {
	  // Menu fenêtre principale
	  $tom_id_courant = $base->meta_topmenu_add_end ($token, $por_id, $nom);
	  $tsm_id_courant = null;
	  $men_id_courant = null;
	  $sme_id_courant = null;
	  $gin_id_courant = null;
	} else {
	  // Menu fenêtre personne
	  $tom_id_courant = null;
	  $tsm_id_courant = null;
	  $men_id_courant = $base->meta_menu_add_end ($token, $por_id, $nom, $ent_id_courant);
	  $sme_id_courant = null;
	  $gin_id_courant = null;
	}
	break;

      case 'sousmenu':
	$type = $ligne[1];
	$typeid = $ligne[2];
	$modif = $ligne[3];
	$suppression = $ligne[4];
	$nom = $ligne[5];
	$icone = $ligne[6];
	$titre = isset ($ligne[7]) ? $ligne[7] : $nom;

	$id = '';
	switch ($type) {
	case 'notes':
	  $nos = $base->notes_notes_get_par_code ($token, $typeid);
	  $id = $nos['nos_id'];
	  break;
	case 'documents':
	  $dos = $base->document_documents_get_par_code ($token, $typeid);
	  $id = $dos['dos_id'];
	  break;
	case 'liste':
	  $lis = $base->liste_liste_get_par_code ($token, $typeid);
	  $id = $lis['lis_id'];
	  break;
	case 'groupe':
	  $sec = $base->meta_secteur_get_par_code ($token, $typeid);
	  $id = $sec['sec_id'];
	  break;
	case 'event':
	  $evs = $base->events_events_get_par_code ($token, $typeid);
	  $id = $evs['evs_id'];
	  break;
	case 'agressources':
	  $agr = $base->events_agressources_get_par_code  ($token, $typeid);
	  $id = $agr['agr_id'];
	  break;
	case 'affectations':
	  $aff = $base->vues_affectations_get_par_code  ($token, $typeid);
	  $id = $aff['aff_id'];
	  break;
	}

	if ($tom_id_courant != null) {
	  // Sous-menu fenêtre principale
	  $tsm_id_courant = $base->meta_topsousmenu_add_end ($token, $tom_id_courant, 
							     $nom, 
							     $icone,
							     $type,
							     $id,
							     $titre,
							     $modif != '',
							     $suppression != '');
	
	} else if ($men_id_courant != null) {
	  // Sous-menu fenêtre personne
	  $sme_id_courant = $base->meta_sousmenu_add_end ($token, $men_id_courant,
							  $nom, 
							  $type, 
							  $id,
							  $modif != '',
							  $suppression != '',
							  $icone);
	  $gin_id_courant = null;
	} else {
	  echo "ERREUR : Dans aucun menu\n";
	  $base->rollback ();
	  exit;	
	}
	break;
      
      case 'bloc':
	$nom = $ligne[1];
	if ($sme_id_courant != null) {
	  $gin_id_courant = $base->meta_groupe_infos_add_end ($token, $sme_id_courant, $nom);
	} else {
	  echo "ERREUR : Dans aucun sous-menu\n";
	  $base->rollback ();
	  exit;	
	}
	break;

      case 'champ':
	$code = $ligne[1];
	$groupecycle = $ligne[2];
	$obligatoire = $ligne[3];
	if ($gin_id_courant != null) {
	  $base->meta_info_groupe_add_end ($token, 
					   $code, 
					   $gin_id_courant, 
					   $groupecycle != '', 
					   $obligatoire != '');
	} else {
	  echo "ERREUR : Dans aucun groupe de champs\n";
	  $base->rollback ();
	  exit;	
	}      
	break;

      default:
	echo $objname." inconnu\n";
	$base->rollback ();
	exit;
      }
    }
  }
}
//exit;
$base->commit ();


function usage () {
  global $argv;
  echo "Usage: $argv[0] 'mot de passe variation'\n";
}
?>

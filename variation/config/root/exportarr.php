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
require 'inc/config.inc.php';
require 'inc/ExcelExport.class.php';
require 'inc/export.inc.php';
$tempdir = null;
?>
<h1>Export arrangement</h1>
 <?php 

/* On récupère quelques infos génériques */
$secteurs = $base->meta_secteur_liste ($_SESSION['token'], NULL, $base->order('sec_code'));

$entites = $base->meta_entite_liste ($_SESSION['token']);
$ent_code = array ();
foreach ($entites as $entite) {
  $ent_code[$entite['ent_id']] = $entite['ent_code'];
}

$infos = $base->meta_info_liste ($_SESSION['token'], NULL, false, NULL);
$inf = array ();
foreach ($infos as $info) {
  $inf[$info['inf_id']] = $info;
}

$infos_types = $base->meta_infos_type_liste ($_SESSION['token']);
$int_code = array ();
foreach ($infos_types as $infos_type) {
  $int_code[$infos_type['int_id']] = $infos_type['int_code'];
}

create_destination_dir ();
export_thematiques ();
export_etablissement ();
export_types_documents ();
export_types_evenements ();
export_groupes_thematiques ();
export_vues_listes ();
export_vues_affectations ();
export_metiers ();
export_boites_notes ();
export_banquechamps ();
export_portail ();
export_public_concerne ();
export_intitules();
 ?>
<a href="/export/arrangement.php">Télécharger export arrangement</a>



<?php
function create_destination_dir () {
  global $tempdir, $dirbase;
  /*  $tempdir = tempnam(sys_get_temp_dir(), '');
  if (file_exists($tempdir)) { 
    unlink($tempdir); 
  }
  mkdir($tempdir);
  */
  $tempdir = $dirbase.'/tmp/arrangement';
  if (file_exists($tempdir)) { 
    $files = glob ($tempdir."/*");
    if (is_array ($files)) {
      foreach ($files as $f) {
	unlink ($f);
      }
    }
  } else {
    mkdir ($tempdir);
  }
}

function export_thematiques () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $excel->addLine (array ('code thematique', 'Nom thematique', 'Icone thematique'));
  $secteurs = $base->meta_secteur_liste($_SESSION['token'], null);
  foreach ($secteurs as $secteur) {
    $excel->addLine (array ($secteur['sec_code'], $secteur['sec_nom'], $secteur['sec_icone']));
  }
  file_put_contents ($tempdir.'/thematiques.csv', $excel->getContents ());
}

function export_etablissement () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $cats = $base->meta_categorie_liste($_SESSION['token']);
  $excel->addLine (array ('Catégorie', $cats[0]['cat_nom']));
  $etas = $base->etablissement_liste($_SESSION['token'], true, null);
  $nom_eta = "-";
  $eta_id = 0;
  foreach ($etas as $eta) {
    if ($eta['cat_id'] == $cats[0]['cat_id']) {
      $nom_eta = $eta['eta_nom'];
      $eta_id = $eta['eta_id'];
      break;
    }
  }
  $excel->addLine (array ('Etablissement', $nom_eta));

  if ($eta_id == 0) {
    $excel->addLine (array ('Thématiques'));
  } else {
    $ligne = array ('Thématiques');
    $secteurs = $base->etablissement_secteur_liste($_SESSION['token'], $eta_id, null);
    $sec_codes = array ();
    foreach ($secteurs as $secteur) {
      $sec_codes[] = $secteur['sec_code'];
    }
    $ligne[] = implode(',', $sec_codes);
    $excel->addLine($ligne);
  }

  $excel->addLine(array('Nom de groupe', 'Code thématique,Code champ associé', '...'));
  $grps = $base->groupe_liste_details($_SESSION['token'], $eta_id, 
				      null, null, true);
  foreach ($grps as $grp) {
    $ligne = array ();
    $ligne[] = $grp['grp_nom'];
    $secs = $base->groupe_secteur_liste($_SESSION['token'], $grp['grp_id'], null);
    foreach ($secs as $sec) {
      $gis = $base->groupe_info_secteur_get($_SESSION['token'], $grp['grp_id'], $sec['sec_code']);
      $secteur = $base->meta_secteur_get($_SESSION['token'], $gis[0]['sec_id']);
      $info = $base->meta_info_get($_SESSION['token'], $gis[0]['inf_id']);
      $ligne[] = $secteur['sec_code'].','.$info['inf_code'];
    }
    $excel->addLine($ligne);
  }
  file_put_contents ($tempdir.'/etablissement.csv', $excel->getContents ());
}

function export_types_documents () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $secteurs = $base->meta_secteur_liste($_SESSION['token'], null, $base->order('sec_code'));
  $entete = array ('type_document');
  foreach ($secteurs as $secteur) {
    $entete[] = $secteur['sec_code'];
  }
  $excel->addLine ($entete);

  $dtys = $base->document_document_type_liste_par_sec_ids ($_SESSION['token'], null, null);
  if (is_array ($dtys)) {
    foreach ($dtys as $dty) {
      $line = array ($dty['dty_nom']);
      $secs = $base->document_document_type_secteur_list ($_SESSION['token'], $dty['dty_id']);
      $sec_ids = array ();
      foreach ($secs as $sec) {
	$sec_ids[$sec['sec_id']] = 'X';
      }
      foreach ($secteurs as $secteur) {
	$line[] = isset ($sec_ids[$secteur['sec_id']]) ? $sec_ids[$secteur['sec_id']] : '';
      }
      $excel->addLine ($line);
    }
  }
  file_put_contents ($tempdir.'/types_documents.csv', $excel->getContents ());
}

function export_types_evenements () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $secteurs = $base->meta_secteur_liste($_SESSION['token'], null, $base->order('sec_code'));
  $entete = array ('type_evenement', 'categorie', 'intitule_individuel');
  foreach ($secteurs as $secteur) {
    $entete[] = $secteur['sec_code'];    
  }
  $excel->addLine ($entete);

  for ($eca_id = 1; $eca_id <= 4; $eca_id++) {
    $etys = $base->events_event_type_list ($_SESSION['token'], $eca_id, null, null);
    if (is_array ($etys)) {
      foreach ($etys as $ety) {
	$line = array ($ety['ety_intitule'], $eca_id, $ety['ety_intitule_individuel'] ? 'X' : '');
	$secs = $base->events_event_type_secteur_list ($_SESSION['token'], $ety['ety_id']);
	$sec_ids = array ();
	if (is_array ($secs)) {
	  foreach ($secs as $sec) {
	    $sec_ids[$sec['sec_id']] = 'X';
	  }
	}
	foreach ($secteurs as $secteur) {
	  $line[] = isset ($sec_ids[$secteur['sec_id']]) ? $sec_ids[$secteur['sec_id']] : '';
	}
	$excel->addLine ($line);
      }
    }
  }
  file_put_contents ($tempdir.'/types_evenements.csv', $excel->getContents ());
}

function export_groupes_thematiques () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $excel->addLine (array('Nom groupe', 'codes thématiques'));
  $segs = $base->meta_secteur_groupe_list_details ($_SESSION['token']);
  if (is_array ($segs)) {
    foreach ($segs as $seg) {
      $excel->addLine (array ($seg['seg_nom'], $seg['secteurs']));
    }
  }
  file_put_contents ($tempdir.'/groupes_thematiques.csv', $excel->getContents ());
}

function export_vues_listes () {
  global $base, $tempdir, $ent_code, $inf, $int_code;
  $xml = new SimpleXMLElement ('<listes></listes>');
  $listes = $base->liste_liste_all ($_SESSION['token']);
  foreach ($listes as $liste) {
    $xml_liste = $xml->addChild ('liste');
    $xml_liste->addChild ('code', $liste['lis_code']);
    $xml_liste->addChild ('nom', $liste['lis_nom']);
    $xml_liste->addChild ('entite', $ent_code[$liste['ent_id']]);
    $xml_liste->addChild ('inverse', $liste['lis_inverse'] ? 'true' : 'false');
    $xml_liste->addChild ('pagination_tout', $liste['lis_pagination_tout'] ? 'true' : 'false');
    $xml_champs = $xml_liste->addChild ('champs');
    $champs = $base->liste_champ_liste ($_SESSION['token'], $liste['lis_id']);
    foreach ($champs as $champ) {
      $xml_champ = $xml_champs->addChild ('champ');
      $xml_champ->addChild ('inf_code', $inf[$champ['inf_id']]['inf_code']);
      $xml_champ->addChild ('libelle', $champ['cha_libelle']);
      $xml_champ->addChild ('filtrer', $champ['cha_filtrer'] ? 'true' : 'false');
      $xml_champ->addChild ('verrouiller', $champ['cha_verrouiller'] ? 'true' : 'false');
      switch ($int_code[$inf[$champ['inf_id']]['int_id']]) {
      case 'groupe':
	$xml_champ->addChild ('groupe_cycle', $champ['cha__groupe_cycle'] ? 'true' : 'false');
	$xml_champ->addChild ('groupe_dernier', $champ['cha__groupe_dernier'] ? 'true' : 'false');
	$xml_champ->addChild ('groupe_contact', $champ['cha__groupe_contact'] ? 'true' : 'false');
	break;
      case 'famille':
	$xml_champ->addChild ('famille_details', $champ['cha__famille_details'] ? 'true' : 'false');
	$xml_champ->addChild ('champs_supp', $champ['cha_champs_supp'] ? 'true' : 'false');
	break;
      case 'contact':
	$xml_champ->addChild ('contact_filtre_utilisateur', $champ['cha__contact_filtre_utilisateur'] ? 'true' : 'false');
	$xml_champ->addChild ('champs_supp', $champ['cha_champs_supp'] ? 'true' : 'false');
	break;
      }

      $defauts = $base->liste_defaut_liste ($_SESSION['token'], $champ['cha_id']);
      if (count ($defauts)) {
	$xml_defauts = $xml_champ->addChild ('defauts');
	foreach ($defauts as $defaut) {	
	  switch ($int_code[$inf[$champ['inf_id']]['int_id']]) {
	  case 'texte':
	    $val = $defaut['def_valeur_texte'];
	    $xml_defaut = $xml_defauts->addChild ('defaut', $val);
	    break;
	  case 'selection':
	  case 'statut_usager':
	  case 'metier':
	    $val = $defaut['def_valeur_int'];
	    $xml_defaut = $xml_defauts->addChild ('defaut', $val);
	    break;
	  case 'groupe':
	    $val1 = $defaut['def_valeur_int'];
	    $val2 = $defaut['def_valeur_int2'];
	    $xml_defaut = $xml_defauts->addChild ('defaut');
	    $xml_defaut->addChild('eta', $val1);
	    $xml_defaut->addChild('grp', $val2);
	    break;
	  }
	}
      }

      $supps = $base->liste_supp_list ($_SESSION['token'], $champ['cha_id']);
      if (count ($supps)) {
	$xml_supps = $xml_champ->addChild ('supps');
	foreach ($supps as $supp) {	
	  $xml_supp = $xml_supps->addChild ('supp', $inf[$supp['inf_id']]['inf_code']);	
	}
      }    
    }
  }

  $dom = new DOMDocument('1.0');
  $dom->preserveWhiteSpace = false;
  $dom->formatOutput = true;
  $dom->loadXML($xml->asXML());
  file_put_contents ($tempdir.'/vues_listes.xml', $dom->saveXML());  
}

function export_vues_affectations () {
  global $base, $tempdir, $inf;
  $xml = new SimpleXMLElement ('<affectations></affectations>');
  $affs = $base->vues_affectations_liste ($_SESSION['token']);
  foreach ($affs as $aff) {
    $xml_aff = $xml->addChild ('affectation');
    $xml_aff->addChild ('code', $aff['aff_code']);
    $xml_aff->addChild ('titre', $aff['aff_titre']);
    $xml_aff->addChild ('info', $inf[$aff['inf_id']]['inf_code']);    
  }
  $dom = new DOMDocument('1.0');
  $dom->preserveWhiteSpace = false;
  $dom->formatOutput = true;
  $dom->loadXML($xml->asXML());
  file_put_contents ($tempdir.'/vues_affectations.xml', $dom->saveXML());  
}

function export_metiers () {
  global $base, $tempdir, $ent_code, $secteurs;
  
  $excel = new ExcelExport ();
  $metiers = $base->metier_liste_details ($_SESSION['token'], null, null);
  $entete = array ('metier', 'personnel', 'contact');
  foreach ($secteurs as $s) {
    $entete[] = $s['sec_code'];
  }
  $excel->addLine ($entete);

  foreach ($metiers as $metier) {
    $tmp = array ();
    $tmp['metier'] = $metier['met_nom'];
    $ents = $base->metier_entite_liste ($_SESSION['token'], $metier['met_id']);
    foreach ($ents as $ent) {
      $tmp[$ent['ent_code']] = 'X';
    }  
    $secs = $base->metier_secteur_liste ($_SESSION['token'], $metier['met_id']);
    if (count ($secs)) {
      foreach ($secs as $sec) {
	$tmp[$sec['sec_code']] = 'X';
      }
    }
    $ligne = array ();
    foreach ($entete as $code) {
      if (isset ($tmp[$code])) {
	$ligne[] = $tmp[$code];
      } else {
	$ligne[] = '';
      }
    }
    $excel->addLine ($ligne);
  }
  file_put_contents ($tempdir.'/metiers.csv', $excel->getContents ());
}

function export_boites_notes () {
  global $base, $tempdir;
  $thes = $base->notes_theme_liste_details ($_SESSION['token'], nuLl);
  $excel = new ExcelExport ();
  foreach ($thes as $the) {
    $excel->addLine (array ($the['the_nom']));
  }
  file_put_contents ($tempdir.'/boites_notes.csv', $excel->getContents ());  
}

function export_banquechamps () {
  global $tempdir;
  $xml = new SimpleXMLElement ('<banque></banque>');
  add_selections ($xml);
  add_dirinfos ($xml, null);
  $dom = new DOMDocument('1.0');
  $dom->preserveWhiteSpace = false;
  $dom->formatOutput = true;
  $dom->loadXML($xml->asXML());
  file_put_contents ($tempdir.'/banquechamps.xml', $dom->saveXML());    
}

function add_selections ($xml) {
  global $base;
  $selections = $xml->addChild ('selections');
  $sels = $base->meta_selection_liste ($_SESSION['token']);
  if (is_array ($sels)) {
    foreach ($sels as $sel) {
      $selection = $selections->addChild ('selection');
      $selection->addChild ('code', $sel['sel_code']);
      $selection->addChild ('libelle', $sel['sel_libelle']);
      $selection->addChild ('info', $sel['sel_info']);
      $entrees = $selection->addChild('entrees');
      $sens = $base->meta_selection_entree_liste($_SESSION['token'], $sel['sel_id']);
      if (is_array ($sens)) {
	foreach ($sens as $sen) {
	  $entree = $entrees->addChild ('entree', $sen['sen_libelle']);
	}
      }
    }
  }
}

function add_dirinfos (&$xml, $din_id_parent) {
  global $base, $int_code;
  $dins = $base->meta_dirinfo_list($_SESSION['token'], $din_id_parent);
  if (is_array ($dins)) {
    foreach ($dins as $din) {
      $dirinfo = $xml->addChild ('dirinfo');
      $dirinfo->addChild ('libelle', $din['din_libelle']);
      add_dirinfos ($dirinfo, $din['din_id']);
      $infos = $dirinfo->addChild ('infos');
      $infs = $base->meta_info_liste_dans_dirinfo($_SESSION['token'], $din['din_id']);
      if (is_array ($infs)) {
	foreach ($infs as $inf) {
	  $info = $infos->addChild ('info');
	  $info->addChild ('code', $inf['inf_code']);
	  $info->addChild ('int_code', $int_code[$inf['int_id']]);
	  $info->addChild ('libelle', $inf['inf_libelle']);
	  $info->addChild ('libelle_complet', $inf['inf_libelle_complet']);
	  $info->addChild ('etendu', $inf['inf_etendu'] ? '1' : '0');
	  $info->addChild ('historique', $inf['inf_historique'] ? '1' : '0');
	  $info->addChild ('multiple', $inf['inf_multiple'] ? '1' : '0');	  
	  $info->addChild ('aide', $base->meta_info_aide_get($_SESSION['token'], $inf['inf_id']));
	  switch ($int_code[$inf['int_id']]) {
	  case "date":
	    $info->addChild ('date_echeance', $inf['inf__date_echeance']);
	    $info->addChild ('date_echeance_icone', $inf['inf__date_echeance_icone']);
	    $info->addChild ('date_echeance_secteur', $inf['inf__date_echeance_secteur']);
	    break;
	  case "textelong":
	    $info->addChild ('textelong_nblignes', $inf['inf__textelong_nblignes']);	    
	    break;
	  case "selection":
	    $sel = $base->meta_selection_infos($_SESSION['token'], $inf['inf__selection_code']);
	    $info->addChild ('selection_code', arrval ($sel, 'sel_code'));
	    break;
	  case "groupe":
	    $info->addChild ('groupe_type', $inf['inf__groupe_type']);
	    $info->addChild ('groupe_soustype', $inf['inf__groupe_soustype']); // TODO code ?
	    break;
	  case "contact":
	    $info->addChild ('contact_filtre', $inf['inf__contact_filtre']);	    
	    $info->addChild ('contact_secteur', $inf['inf__contact_secteur']);	    
	    break;
	  case "metier":
	    $info->addChild ('metier_secteur', $inf['inf__metier_secteur']);	    
	    break;
	  case "etablissement":
	    $info->addChild ('etablissement_interne', $inf['inf__etablissement_interne']);
	    $info->addChild ('etablissement_secteur', $inf['inf__etablissement_secteur']);
	    break;
	  case "date_calcule":
	  case "coche_calcule":
	    $info->addChild('formule', $inf['inf_formule']);
	    break;

	  }
	}
      }
    }
  }
}

function export_portail () {
  global $base, $tempdir;
  $pors = $base->meta_portail_liste ($_SESSION['token'], NULL);
  $i = 1;
  foreach ($pors as $por) {
    $excel = new ExcelExport ();
    $p = exporte_portail_csv ($_SESSION['token'], $excel, $por);
    file_put_contents ($tempdir.'/portail'.$i.'.csv', $excel->getContents ());
    $i++;
  }
}

function export_public_concerne() {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $sets = $base->meta_secteur_type_liste_par_code ($_SESSION['token'], 'prise_en_charge');
  foreach ($sets as $set) {
    $excel->addLine (array($set['set_nom']));
  }
  file_put_contents ($tempdir.'/public_concerne.csv', $excel->getContents ());  
}

function export_intitules () {
  global $base, $tempdir;
  $excel = new ExcelExport ();
  $secteurs = $base->meta_secteur_liste($_SESSION['token'], null, $base->order('sec_code'));
  $entete = array ('code_intitule', 'defaut');
  foreach ($secteurs as $secteur) {
    $entete[] = $secteur['sec_code'];
  }
  $excel->addLine ($entete);

  $ters = $base->localise_terme_liste_details ($_SESSION['token']);
  if (is_array ($ters)) {
    foreach ($ters as $ter) {
      $line = array ($ter['ter_code']);      
      $defaut = $base->localise_par_code_secteur($_SESSION['token'], $ter['ter_code'], null);
      $line[] = $defaut;
      foreach ($secteurs as $secteur) {
	$val = $base->localise_par_code_secteur($_SESSION['token'], $ter['ter_code'], $secteur['sec_code']);
	$line[] = ($val == $defaut) ? "" : $val;
      }
      $excel->addLine ($line);
    }
  }
  file_put_contents ($tempdir.'/intitules.csv', $excel->getContents ());
}
?>

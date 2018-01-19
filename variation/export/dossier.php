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
?><?php
	require ('../inc/config.inc.php');
	require ('../inc/common.inc.php');
	require ('../inc/localise.inc.php');
	require ('../inc/enums.inc.php');
	require ('../inc/pgprocedures.class.php');
	$base = new PgProcedures ($pghost, $pguser, $pgpass, $pgbase);
	require ('../inc/infos/info.class.php');
	$per_id = $_GET['per_id'];
for($k=1; $k<=4; $k++){
    $statut = $base->localise_par_code_secteur($_SESSION['token'], 'statut_usager_'.$k, NULL);
    if(!empty($statut)){$statuts_usager[$k] = $statut;}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>VARIATION</title>

    <link href="/css/dossierprint.css" rel="stylesheet" type="text/css" />
  </head>
  <body  onload="window.print()" style="padding: 0; margin: 0;background-color: #fff">
   
   <div style="padding: 10px">

		<?php
		$etab = $base->etablissement_get($_SESSION['token'], $_SESSION['eta_id']);
		$adr = $base->adresse_get($_SESSION['token'],$etab['adr_id']);	 
		$adresse = $etab['eta_nom']."<br />".$adr['adr_adresse']."<br />".$adr['adr_cp']."&nbsp;".$adr['adr_ville'];
		$nom = $base->personne_info_varchar_get ($_SESSION['token'], $per_id, 'nom');
		$prenom = $base->personne_info_varchar_get ($_SESSION['token'], $per_id, 'prenom');
		$info_types = $base->meta_infos_type_liste ($_SESSION['token']);  
		$int_code = array ();
		foreach ($info_types as $info_type) {
		  $int_code[$info_type['int_id']] = $info_type['int_code'];
		}
		function affiche_info ($info) {
			  global $int_code;
			  $affiche_libelle = ($int_code[$info['int_id']] != 'groupe');
			  /* Affiche le libellé */
			  if ($affiche_libelle) 
				echo '<span class="libelle">'.$info['inf_libelle'].' : </span>';

			  
			  /* Affiche selon le type */
			  switch ($int_code[$info['int_id']]) {
			  case 'texte':           affiche_info_texte ($info); break;
			  case 'date':            affiche_info_date ($info); break;
			  case 'textelong':       affiche_info_textelong ($info); break;
			  case 'coche':           affiche_info_coche ($info); break;
			  case 'selection':       affiche_info_selection ($info); break;
			  case 'groupe':          affiche_info_groupe ($info); break;
			  case 'contact':         affiche_info_contact ($info); break;
			  case 'metier':          affiche_info_metier ($info); break;
			  case 'etablissement':   affiche_info_etablissement ($info); break;
			  case 'affectation':     affiche_info_affectation ($info); break;
			  case 'famille':         affiche_info_famille ($info); break;
			  case 'statut_usager':   affiche_info_statut_usager ($info); break;
			  case 'date_calcule':    affiche_info_date_calcule ($info); break;
			  case 'coche_calcule':    affiche_info_coche_calcule ($info); break;
			  }
			  
			}
			
			
			function affiche_info_groupe ($info){
				 global $base, $per_id, $cycle_statuts;
				 
				  $affiche_date_debut = false;
				  $affiche_date_fin = false;
				  $affiche_date_demande = false;
				  $affiche_date_demande_renouvellement = false;
				  $ing = $base->meta_info_groupe_get ($_SESSION['token'], $info['ing_id']);
				  $cycle = $ing['ing__groupe_cycle'];
				  $type = $info['inf__groupe_type'];  
				  $soustype = $info['inf__groupe_soustype'];
				  echo '<table width="100%"><tr>';
				  echo '<th>'.$info['inf_libelle'].'</th>';
				  if (localise_par_code_secteur ('info_groupe_date_debut', $type)) {
					echo '<th width="100">'.localise_par_code_secteur ('info_groupe_date_debut', $type).'</th>';
					$affiche_date_debut = true;
				  }
				  if (localise_par_code_secteur ('info_groupe_date_fin', $type)) {
					echo '<th width="100">'.localise_par_code_secteur ('info_groupe_date_fin', $type).'</th>';
					$affiche_date_fin = true;
				  }
				  if (!$affiche_date_debut && !$affiche_date_fin) {
					echo 'Erreur : Les traductions de date_debut et date_fin ne doivent pas être vides ensemble.';
					return;
				  }    
				  if ($cycle) {
					echo '<th width="100">Statut</th>';
					if (localise_par_code_secteur ('info_groupe_date_demande', $type)) {
					  echo '<th width="100">'.localise_par_code_secteur ('info_groupe_date_demande', $type).'</th>';
					  $affiche_date_demande = true;
					}
					if (localise_par_code_secteur ('info_groupe_date_demande_renouvellement', $type)) {
					  echo '<th width="100">'.localise_par_code_secteur ('info_groupe_date_demande_renouvellement', $type).'</th>';
					  $affiche_date_demande_renouvellement = true;
					}
				  }
				  
				  echo '</tr>';
				  $groupes = $base->personne_groupe_liste2 ($_SESSION['token'], $per_id, $info['inf_id']);
				  if (count ($groupes)) {
					$impair = true;
					foreach ($groupes as $groupe) {
					  echo '<tr class="'.($impair ? 'impair' : 'pair').'"><td>';
					  echo $groupe['eta_nom'].' &rarr; '.$groupe['grp_nom'];
					  if ($affiche_date_debut) {
					echo '</td><td align="center">';
					echo $groupe['peg_debut'];
					  }
					  if ($affiche_date_fin) {
					echo '</td><td align="center">';
					echo $groupe['peg_fin'];
					  }
					  echo '</td>';
					  if ($cycle) {	
					echo '<td align="center">'.$cycle_statuts[$groupe['peg_cycle_statut']].'</td>';
					if ($affiche_date_demande) {
					  echo '<td align="center">'.$groupe['peg_cycle_date_demande'].'</td>';
					}
					if ($affiche_date_demande_renouvellement) {
					  echo '<td align="center">'.$groupe['peg_cycle_date_demande_renouvellement'].'</td>';
					}
					  }
					  
					  echo '</tr>';            
					  $impair = !$impair;
					}
				  } else {
					echo '<tr class="impair"><td align="center" colspan="7"><i>Pas de '.$info['inf_libelle'].' enregistré</i></td></tr>';
				  }

				  
				  echo '</table>';
			}

			
			
			
			function affiche_info_contact ($info){
				global $base, $per_id, $reperes;
				  
					$multiple = $info['inf_multiple'];  
					if ($multiple) {
					  $classe ='infocontact_ro';
					  $valeurs = $base->personne_info_integer_get_multiple_details ($_SESSION['token'], $per_id, $info['inf_code']);
					  echo '<div id="'.$info['inf_code'].'_'.'list">';
					  if (count ($valeurs)) {
					foreach ($valeurs as $valeur) {
					  $nomprenom = $base->personne_get_libelle ($_SESSION['token'], $valeur['pii_valeur']);
					  echo '<span id="pii_'.$valeur['pii_id'].'" class="'.$classe.'"><nobr><span id="lienpersonne_'.$info['inf__contact_filtre'].'_'.$valeur['pii_valeur'].'" class="lienpersonne">'.$nomprenom.'</span></nobr></span> ';
					}
					  }
					  echo '</div>';
					  
					
					} else {
					  $classe =  'infocontact1_ro';
					  $valeur = $base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']);    
					  $nomprenom = $base->personne_get_libelle ($_SESSION['token'], $valeur);
					  echo '<span class="'.$classe.'" id="infocontact1_'.$info['inf_code'].'"><nobr>'.$nomprenom.'</nobr></span>';
					}
				  
			}
			
			function affiche_info_metier ($info) {
			  global $base, $per_id;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$dim = '[]';
				$valeurs = $base->personne_info_integer_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				$valeurs[] = null;
			  } else {
				$dim = '';
				$valeurs = array ($base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']));
			  }
			  //  $met_id = $base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']);
			  $metiers = $base->metier_liste ($_SESSION['token'], $info['inf__metier_secteur']);
			  foreach ($valeurs as $met_id) {    
				
				foreach ($metiers as $metier) {
				  if($met_id == $metier['met_id'])
				  echo $metier['met_nom'];
				}
				echo '<br/>';
			  }
			}

			
			
			
			
			function affiche_info_etablissement ($info) {
			  global $base, $per_id, $droit_modif;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$classe = 'infoetab_ro';
				$valeurs = $base->personne_info_integer_get_multiple_details ($_SESSION['token'], $per_id, $info['inf_code']);
				echo '<div id="'.$info['inf_code'].'_'.'list">';
				foreach ($valeurs as $valeur) {
				  $etab = $base->etablissement_get ($_SESSION['token'], $valeur['pii_valeur']);
				  echo '<span id="pii_'.$valeur['pii_id'].'" class="'.$classe.'"><nobr>'.$etab['eta_nom'].'</nobr></span> ';
				}
				echo '</div>';

			  } else {
				$classe =  'infoetab1_ro';
				$valeur = $base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']);
				$etab = $base->etablissement_get ($_SESSION['token'], $valeur);
				echo '<span class="'.$classe.'" id="infoetab1_'.$info['inf_code'].'"><nobr>'.$etab['eta_nom'].'</nobr></span>';
			  }
			}
			function affiche_info_affectation ($info) {
			  global $base, $per_id;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$classe = 'infoaffectation';
				$valeurs = $base->personne_info_integer2_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				echo '<div id="'.$info['inf_code'].'_'.'list">';
				foreach ($valeurs as $valeur) {
				  $etab = $base->etablissement_get ($_SESSION['token'], $valeur['valeur1']);
				  echo '<span id="pij_'.$valeur['pij_id'].'" class="'.$classe.'"><nobr>'.$etab['eta_nom'];
				  if ($valeur['valeur2']) {
				$grp = $base->groupe_get ($_SESSION['token'], $valeur['valeur2']);
				echo ' &rarr; '.$grp['grp_nom'];
				  }
				  echo '</nobr></span> ';
				}
				echo '</div>';
			  } 
				echo 'Affectation non multiple Non implémenté';
			  
			}
			
			
			
			function affiche_info_famille ($info) {
			  global $base, $per_id, $ent_code;
			  // On considère que c'est multiple
				$classe = 'membrefam';
				$valeurs = $base->personne_info_lien_familial_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				echo '<div id="'.$info['inf_code'].'_'.'list">';
				if (is_array ($valeurs)) {
				  foreach ($valeurs as $valeur) {
					$libelle = $base->personne_get_libelle ($_SESSION['token'], $valeur['per_id_parent']);
					$lien = $base->meta_lien_familial_get ($_SESSION['token'], $valeur['lfa_id']);
					echo '<span><nobr>'.$lien['lfa_nom'].' : '.$libelle.'</nobr></span><br />';
				  }
				}
				echo '</div>';
			  
			}
			
			
			
			
			
			function affiche_info_statut_usager ($info) {
			  global $base, $per_id, $statuts_usager;
			  $valeur = $base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']);
			  echo $statuts_usager[$valeur];
			}
			
			
			function affiche_info_date_calcule ($info) {
			  global $per_id;
			  $obj = new Info_date_calcule ($info);
			  echo $obj->valeurCalculee ($per_id);
			}

			function affiche_info_coche_calcule ($info) {
			  global $per_id;
			  $obj = new Info_coche_calcule ($info);
			  $res = $obj->valeurCalculee ($per_id);
			  echo ($res ? ' Oui' : 'Non');
			}
			
			
			function affiche_info_selection ($info) {
			  global $base, $per_id;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$dim = '[]';
				$valeurs = $base->personne_info_integer_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				$valeurs[] = null;
			  } else {
				$dim = '';
				$valeurs = array ($base->personne_info_integer_get ($_SESSION['token'], $per_id, $info['inf_code']));
			  }
			  $selection = $base->meta_selection_infos ($_SESSION['token'], $info['inf__selection_code']);
			  $entrees = $base->meta_selection_entree_liste ($_SESSION['token'], $info['inf__selection_code']);

			  foreach ($valeurs as $valeur) {
				foreach ($entrees as $entree) {
				  if ($entree['sen_id'] == $valeur){echo '<p>'.$entree['sen_libelle'].'</p>';}
				  
				}
			  }
			}
			
			
			
			
			function affiche_info_coche ($info) {
			  global $base, $per_id;
			  $valeur = $base->personne_info_boolean_get ($_SESSION['token'], $per_id, $info['inf_code']);
			  $checked = $valeur ? " Oui" : "Non";
			  echo $checked;
			}
			
			
			function affiche_info_textelong ($info) {
			  global $base, $per_id;
			  $valeur = $base->personne_info_text_get ($_SESSION['token'], $per_id, $info['inf_code']);
			  echo '<p>'.nl2br($valeur).'</p>';
			}
			
			
			function affiche_info_texte ($info) {
			  global $base, $per_id;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$dim = '[]';
				$valeurs = $base->personne_info_varchar_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				$valeurs[] = null;
			  } else {
				$dim = '';
				$valeurs = array ($base->personne_info_varchar_get ($_SESSION['token'], $per_id, $info['inf_code']));
			  }
			  foreach ($valeurs as $valeur) {
				echo '<p>'.$valeur.'</p>';
			  }
			}
			
			
			function affiche_info_date ($info) {
			  global $base, $per_id;
			  $multiple = $info['inf_multiple'];  
			  if ($multiple) {
				$dim = '[]';
				$valeurs = $base->personne_info_date_get_multiple ($_SESSION['token'], $per_id, $info['inf_code']);
				$valeurs[] = null;
			  } else {
				$dim = '';
				$valeurs = array ($base->personne_info_date_get ($_SESSION['token'], $per_id, $info['inf_code']));
			  }
			  foreach ($valeurs as $valeur) {
				echo '<p>'.$valeur.'</p>';
			  }
			}
		
		if (file_exists ($dirbase.'/photos/'.$per_id.'/photo.png')) {
			$url_photo = '/photos/'.$per_id.'/photo.png';
		} else {
			$url_photo = '/photos/0/photo.png';
		}
		echo "<div class='photo'><img src='".$url_photo."' /></div>";
		echo '<h2 class="titre_couverture">Dossier de l\'usager</h2><h1>'.$nom.' '.$prenom.'<br />';  
		
		echo '</h1>';  
		
		echo '<h2 id="adresse">'.nl2br($adresse).'</h2>';
		echo "<h2 id='confidentiel'>CONFIDENTIEL</h2>";
		$uti = $base->utilisateur_get($_SESSION['token'],$_SESSION['uti_id']);
		$uti_per_id = $uti['per_id'];
		$nom = $base->personne_info_varchar_get($_SESSION['token'],$uti_per_id,'nom');
		$prenom = $base->personne_info_varchar_get($_SESSION['token'],$uti_per_id,'prenom');
		echo "<p id='print_by'>Imprimé par ".$nom." ".$prenom." le ".date('d/m/Y')."<br />".$texte_date_dossier."</p>";
		
		$texte_date_dossier = "Dossier de l'usager depuis son inscription";
		if($_GET['debut']=='debut'){
			$_GET['debut']=null;
		}else{
			$texte_date_dossier = "Dossier de l'usager depuis le ".$_GET['debut'];
		}
		echo '<div style="page-break-after:always;"></div>';
		
		$last_men_id = 0;
		$menu_sommaires=array();
		$sommaire = array();
		
		foreach($_GET['i'] as $sme){
			$infos = $base->meta_sousmenu_infos($_SESSION['token'],$sme);
			if($last_men_id != $infos['men_id']){
				$last_men_id = $infos['men_id'];
				$menu_sommaires[]=$sommaire;
				$sommaire = array();
				$sommaire[]=$infos['sme_libelle'];
			}else{
				$sommaire[]=$infos['sme_libelle'];
			}
		}
		$menu_sommaires[]=$sommaire;
		
		$last_men_id = 0;
		$index_sommaire = 0;
		echo "<h1>Sommaire:</h1>";
		foreach($_GET['i'] as $id_sme){ // Affichage sommaire
			echo "<ul>";
			$infos_fiche = $base->meta_sousmenu_infos($_SESSION['token'],$id_sme);
			if($last_men_id != $infos_fiche['men_id']){
				$last_men_id = $infos_fiche['men_id'];
				$men = $base->meta_menu_infos($_SESSION['token'],$last_men_id);
				echo "<li>".$men['men_libelle']."</li><ul>";
				$index_sommaire++;
				foreach($menu_sommaires[$index_sommaire] as $titre){
					echo "<li>".$titre.'</li>';
				}
				echo "</ul>";
				
				
				
			}
			echo "</ul>";
		}echo "</ul><div style='page-break-after:always;'></div>";
		
		
		
		
		
		$menu_sommaires[]=array();
		$menu_sommaires[]=$sommaire;
		
		$last_men_id = 0;
		$index_sommaire = 0;
		
		foreach($_GET['i'] as $id_sme){
			$infos_fiche = $base->meta_sousmenu_infos($_SESSION['token'],$id_sme);
			
			if($last_men_id != $infos_fiche['men_id']){
				$last_men_id = $infos_fiche['men_id'];
				$men = $base->meta_menu_infos($_SESSION['token'],$last_men_id);
				echo "<div style='page-break-after:always;'></div><h2 class='new_page_h2'>".$men['men_libelle']."</h2><div class='separation'></div>";
				// echo "<h2>Sommaire:</h2>";
				// $index_sommaire++;
				// foreach($menu_sommaires[$index_sommaire] as $titre){
					// echo "<h3> - ".$titre.'</h3>';
				// }
				
				
				
				// echo "<div style='page-break-after:always;'></div>";
			}
			echo "<div class='noBreak'><h3 class='ss_partie'>".$men['men_libelle']." > ".$infos_fiche['sme_libelle']."</h3>";
			
			if ($infos_fiche['sme_type'] == 'documents') {
				$dos_id = $infos_fiche['sme_type_id'];
				$docs = $base->document_document_liste ($_SESSION['token'], $dos_id, $per_id,
					    $_GET['debut'], NULL,
					    NULL, NULL, NULL);
				echo "<ul>"		;
				if(count($docs))foreach($docs as $doc){
					$type = $base->document_document_type_get ($_SESSION['token'], $doc['dty_id']);
					$responsable = $base->personne_get_libelle ($_SESSION['token'], $doc['per_id_responsable']);
					echo '<li class="noBreak"><strong>'.$doc['doc_titre'].'';
					echo '('.$doc_statut[$doc['doc_statut']].'): </strong><ul>';
					$usagers = $base->document_document_usager_liste ($_SESSION['token'], $doc['doc_id']);
					  echo '<li>Type de document:'.$type['dty_nom'].'</li>';
					  if(!empty($doc['doc_date_obtention'])){
						  echo '<li>Date d\'obtention:'.$doc['doc_date_obtention'].'</li>';
					  }
					  if(!empty($doc['doc_date_realisation'])){
						  echo '<li>Date de réalisation:'.$doc['doc_date_realisation'].'</li>';
					  }
					  if(!empty($doc['doc_date_validite'])){
						  echo '<li>Date de validité:'.$doc['doc_date_validite'].'</li>';
					  }
					  echo '<li>Responsable: '.$responsable.'</li>';
					  echo '</ul></li>';
					
				}else{
					echo "<li class='nothing_saved'>Aucun document enregistré</li>";
				}
				echo"</ul>";
				
				if (count($docs)){
					echo '<div class="separation"></div>';
				}
			  } else if ($infos_fiche['sme_type'] == 'event') {
				$liste_events = $base->events_event_liste($_SESSION['token'],$infos_fiche['sme_type_id'],$per_id,$_GET['debut'],NULL,NULL,NULL,NULL);
				echo "<ul class='noBreak'>";
				if(count($liste_events))foreach($liste_events as $event){
					$date_event ="";
					
					if($event['eve_debut']==$event['eve_fin']){
						$date_event=date('d/m/Y h:i:s',$event['eve_debut']);
					}
					else{
						$date_event=date('d/m/Y h:i:s',$event['eve_debut'])." > ".date('d/m/Y h:i:s',$event['eve_fin'],$_GET['debut'],NULL);
					}
					echo "<li>".$event['eve_intitule']." (".$date_event.")</li>";
					
				}else{
					echo "<li class='nothing_saved'>Aucun événement enregistré</li>";
				}
				echo "</ul>";
				
				if (count($liste_events)){
					echo '<div class="separation"></div>';
				}
			  } else if ($infos_fiche['sme_type'] == 'notes') {
				$liste_notes = $base->notes_note_usager_liste($_SESSION['token'],$per_id,$infos_fiche['sme_type_id'],$_GET['debut'],null);
				
				echo "<ul class='noBreak'>";
				if(count($liste_notes))foreach($liste_notes as $note){
					$objet = "non défini";
					if($note['not_objet']!=""){
					  $objet = textprotect($note['not_objet']);
					}
					echo "<li class='noBreak'><strong>Objet:".$objet."</strong>";
					echo "<ul>";
					echo "<li>".textprotect($note['not_texte'])."</li>";
					echo "<li>Saisie le ".$note['not_date_saisie']."</li>";
					echo "<li>Date de l'évènement: ".$note['not_date_evenement']."</li>";
					$auteur = $base->personne_get_libelle ($_SESSION['token'], $note['uti_id_auteur']);
					echo "<li>Auteur: ".$auteur."</li>";
					echo "</ul>";
					echo "</li>";
				}else{
					echo "<li class='nothing_saved'>Aucune note enregistrée</li>";
				}
				echo "</ul>";
				if (count($liste_notes)){
					echo '<div class="separation"></div>';
				}
			  }else if (!$infos_fiche['sme_type']){

				  $groupes = $base->meta_groupe_infos_liste ($_SESSION['token'], $infos_fiche['sme_id']);
					if (count ($groupes)) {
					  $first = true;
					  foreach ($groupes as $groupe) {
					$first = false;
					echo '<div class="noBreak"><p class="titre2">'.$groupe['gin_libelle'].'</p>';
					$infos = $base->meta_info_groupe_liste ($_SESSION['token'], $groupe['gin_id']);
					$prochain_premier = true;
					if (count ($infos)) {
					  foreach ($infos as $info) {
						$premier = false;
						$dernier = false;
						if ($info['inf_etendu']) {
						  $premier = true;
						  $dernier = true;
						  $prochain_premier = true;
						} else if ($int_code[$info['int_id']] == 'groupe') {
						  $premier = true;
						  $dernier = true;
						  $prochain_premier = true;	    
						} else {
						  if ($prochain_premier == true) {
						$premier = true;
						  } else {
						$dernier = true;
						  }
						  $prochain_premier = !$prochain_premier;
						}
						affiche_info ($info);
						  echo '<br />';
					  }
					}
					echo "</div>";
				  }
				}
			  }
			
			
			
			
			echo '</div>';
		}
		?>   
	</div>
  </body>
</html>

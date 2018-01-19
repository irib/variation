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
<h1>Qualité des données</h1>
<ul>
<?php
$infos_utilises = $base->meta_info_liste ($_SESSION['token'], NULL, true, NULL);
$infos = $base->meta_info_liste ($_SESSION['token'], NULL, NULL, NULL);
$champs_supp = $base->liste_supp_list($_SESSION['token'], NULL);

/********************************************************************/
echo '<li><strong>Champs multiples et historisés utilisés dans l\'interface&nbsp;: </strong>';
$err = array ();
foreach ($infos_utilises as $info) {
  if ($info['inf_multiple'] && $info['inf_historique']) {
    $err[] = $info;
  }
}
if (count ($err)) {
  echo '<ul>';
  foreach ($err as $info) {
    echo '<li>'.$info['inf_libelle'].' ('.$info['inf_code'].')</li>';
  }
  echo '</ul>';
} else {
  echo "OK";
}
echo '</li>';

/********************************************************************/
echo '<li><strong>Champs multiples et historisés dans la banque de champs&nbsp;: </strong>';
$err = array ();
foreach ($infos as $info) {
  if ($info['inf_multiple'] && $info['inf_historique']) {
    $err[] = $info;
  }
}
if (count ($err)) {
  echo '<ul>';
  foreach ($err as $info) {
    echo '<li>'.$info['inf_libelle'].' ('.$info['inf_code'].')</li>';
  }
  echo '</ul>';
} else {
  echo "OK";
}
echo '</li>';

/********************************************************************/
echo '<li><strong>Champs supplémentaires de colonne Famille/Lien de type autre que Texte&nbsp;: </strong>';
$err = array ();
foreach ($champs_supp as $supp) {
  if ($supp['int_id'] != 1) {
    $err[] = $info;
  }
}
if (count ($err)) {
  echo '<ul>';
  foreach ($err as $info) {
    echo '<li>'.$info['inf_libelle'].' ('.$info['inf_code'].')</li>';
  }
  echo '</ul>';
} else {
  echo "OK";
}
echo '</li>';

/********************************************************************/
echo '<li><strong>Vues de listes non utilisées&nbsp;: </strong>';
$listes = $base->liste_liste_inutilisees($_SESSION['token']);
if (is_array ($listes)) {
  echo '<ul>';
  foreach ($listes as $liste) {
    echo '<li>';
    echo $liste['lis_nom'];
    echo '</li>';

  }
  echo '</ul>';
}
echo '</li>';

/********************************************************************/
echo '<li><strong>Champs non utilisés&nbsp;: </strong>';
$infs = $base->meta_info_inutilises($_SESSION['token']);
if (is_array ($infs)) {
  echo '<ul>';
  foreach ($infs as $inf) {
    echo '<li>';
    echo $inf['inf_libelle'].' ('.$inf['inf_code'].')';
    echo '</li>';
  }
  echo '</ul>';
}
echo '</li>';

/********************************************************************/
echo '<li><strong>Listes de sélection non utilisées&nbsp;: </strong>';
$sels = $base->meta_selection_inutilisees($_SESSION['token']);
//print_r($sels);
if (is_array ($sels)) {
  echo '<ul>';
  foreach ($sels as $sel) {
    echo '<li>';
    echo $sel['sel_libelle'].' ('.$sel['sel_code'].')';
    echo '</li>';
  }
  echo '</ul>';
}
echo '</li>';

/********************************************************************/
echo "<li><strong>Coherence droit d'ajout / Champs obligatoires: </strong>";
$entites = $base->meta_entite_liste($_SESSION['token']);
$categories = $base->meta_categorie_liste($_SESSION['token']);

foreach($categories as $cat){
	$portails = $base->meta_portail_liste($_SESSION['token'],$cat['cat_id']);
	$err=array();
	foreach($portails as $port){
		$droit_ajouts = $base->droit_ajout_entite_portail_liste_par_portail($_SESSION['token'],$port['por_id']);
		foreach($droit_ajouts as $droit){
			if($droit['daj_droit']){
				$champs = $base->meta_info_groupe_obligatoire_liste($_SESSION['token'],$port['por_id'],$droit['ent_code']);
				if(count($champs)==0){
					$err[] = "<li>Pas de champs obligatoire pour le portail ".$port['por_libelle']."/".$droit['ent_code']."</li>";
				}
			}
		}
	}
	if(count($err)){
		echo "<ul>".implode("\n",$err)."</ul>";
	}
	else{
		echo "OK";
	}
}
echo '</li>'
?>

<?php
/********************************************************************/
echo "<li><strong>Champs apparaissant dans au moins une liste mais dans aucun masque de saisie: </strong>";
$infs = $base->meta_info_listes_non_editables($_SESSION['token']);
if (is_array ($infs)) {
  echo '<ul>';
  foreach ($infs as $inf) {
    echo '<li>';
    echo $inf['inf_libelle'].' ('.$inf['inf_code'].')';
    echo '</li>';
  }
  echo '</ul>';
}
echo '</li>'
?>
</li>
</ul>
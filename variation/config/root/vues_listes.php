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
include ("inc/pagination.php");

if (!$_SESSION['uti_root'])
  exit;

$erreur = array ();

$entites = $base->meta_entite_liste ($_SESSION['token']);

$pagination = new Pagination ($base);
$pagination->setImagesPath ('/Images/navig');
$pagination->setDefaultColOrder (2);
$pagination->setFunction ('liste_liste_details', array ($_SESSION['token']));
$pagination->setUrl ('/admin.php', array ());
$pagination->addColumn ('Nom', 'lis_nom', 'lien_edit_liste', 'lis_id');
$pagination->addColumn ('Type de personne', 'ent_libelle');
$pagination->setLines (15);

/* Gestion de l'édition des vues listes, à droite */

if (isset ($_POST['nom_dupli']) && $_POST['nom_dupli'] != "") {
  $base->liste_liste_duplicate($_SESSION['token'], $_GET['lis'], $_POST['nom_dupli']);
  header ('Location: '.$_SERVER['REQUEST_URI']);
}

if (isset ($_POST['ed_enreg'])) {
  if (liste_save ($_POST)) {
    header ('Location: '.$_SERVER['REQUEST_URI']);
    exit;
  }
}

if (isset ($_GET['lis'])) {
  $lis_id = (int)$_GET['lis'];
  if (count ($erreur)) {
    // Si on enregistre et qu'il y a des erreurs 
    $lis['lis_id'] = $lis_id;
    $lis['lis_nom'] = $_POST['ed_nom'];
    $lis['lis_code'] = $_POST['ed_code'];
    $lis['lis_inverse'] = $_POST['ed_inverse'];
    $lis['lis_pagination_tout'] = $_POST['ed_tout'];
  } else {    
    $lis = $base->liste_liste_get ($_SESSION['token'], $lis_id);
  }
} else {
  if (count ($erreur)) {
    // Si on ajoute et qu'il y a une erreur 
    $lis['lis_id'] = $lis_id;
    $lis['lis_nom'] = $_POST['ed_nom'];
    $lis['lis_code'] = $_POST['ed_code'];
    $lis['lis_inverse'] = $_POST['ed_inverse'];
    $lis['lis_pagination_tout'] = $_POST['ed_tout'];
  } else {
    $lis = array ();
  }
}
?>
<script type="text/javascript">
$(document).ready (function () {
    $("#dupliquer").click (on_dupliquer_click);
});

function on_dupliquer_click () {
  var nomdupli;
  if ((nomdupli = prompt("Nom de la nouvelle vue de liste : "))) {
    $("#dupli").val(nomdupli);
    $("#ed_form").submit ();
  }
}
</script>
<h1>Vues de listes</h1>

<table width="470" class="t1" style="float: left">
  <?php $pagination->displayHeader (); ?>
  <?php $pagination->displayData (array ('lis_nom', 'ent_libelle')); ?>
  <tr><td colspan="4" align="center" class="navigtd">
  <?php $pagination->displayPagination (); ?>
  </td></tr>
</table>

<?php if (isset ($_GET['lis'])) { ?>
<form id="ed_form" method="post" action="<?= $_SERVER['REQUEST_URI'] ?>">
<table class="t1" width="370" style="margin-left: 480px">
  <tr><th colspan="2">Éditer</th></tr>
  <tr class="impair">
    <td>Nom</td>
     <td><input size="30" name="ed_nom" value="<?= arrval ($lis, 'lis_nom', '') ?>"></input><?= arrval ($erreur, 'ed_nom', '') ?></td>
  </tr>

  <tr class="pair">
    <td>Code</td>
     <td><input size="30" name="ed_code" value="<?= arrval ($lis, 'lis_code', '') ?>"></input><?= arrval ($erreur, 'ed_code', '') ?></td>
  </tr>

  <tr class="impair">
    <td>Type de personne</td>
    <td><select name="ed_ent_id"><option value=""></option>
   <?php liste_entites($lis) ?>
      </select> <?= arrval ($erreur, 'ed_ent_id', '') ?>
    </td>
  </tr>

  <tr class="pair">
    <td>Affichage inversé</td>
   <td><input type="checkbox" name="ed_inverse"<?= $lis['lis_inverse'] ? ' checked' : ''?>></input>
    </td>
  </tr>

  <tr class="pair">
    <td>Afficher toutes lignes</td>
   <td><input type="checkbox" name="ed_tout"<?= $lis['lis_pagination_tout'] ? ' checked' : ''?>></input>
    </td>
  </tr>

  <tr><td class="navigtd" align="right" colspan="2">
    <input type="hidden" name="nom_dupli" id="dupli" value=""></input>
    <button id="dupliquer" name="ed_dupliquer" type="button">Dupliquer</button>
    <button name="ed_enreg" type="submit">Mettre à jour</button>
  </td></tr>
</table>
</form>
<?php } ?>


<div style="clear: both"></div>


<?php
function liste_entites ($lis) {
  global $entites;
  foreach ($entites as $entite) {
    $selected = $lis['ent_id'] == $entite['ent_id'] ? ' selected' : '';
    echo '<option value="'.$entite['ent_id'].'"'.$selected.'>'.$entite['ent_libelle'].'</option>';
  }
}

function lien_edit_liste ($lis_id) {
  return array ('/admin.php', array ('lis' => $lis_id));
}

function liste_save ($post) {
  global $erreur;
  if (!strlen ($post['ed_nom'])) {
    set_erreur ('ed_nom');
  }
  if (!strlen ($post['ed_code'])) {
    set_erreur ('ed_code');
  }
  if (!strlen ($post['ed_ent_id'])) {
    set_erreur ('ed_ent_id');
  }
  if (count ($erreur))
    return false;

  global $base;
  $lis_id = $_GET['lis'];
  $base->liste_liste_update ($_SESSION['token'], $lis_id, $post['ed_nom'], $post['ed_code'], $post['ed_ent_id'], $post['ed_inverse'] == 'on', $post['ed_tout'] == 'on');

  return true;
}

function set_erreur ($code) {
  global $erreur;
  $erreur[$code] = '<img src="/Images/icons/exclamation-small.gif" height="20" align="top"></img>';
}
?>

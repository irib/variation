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
require ('../inc/config.inc.php');
require ('../inc/common.inc.php');
require ('../inc/pgprocedures.class.php');

//if (!$_SESSION['uti_root'])
//  exit;

$base = new PgProcedures ($pghost, $pguser, $pgpass, $pgbase);

if (!$_POST['sel_id']) {
  exit;
}

$sel_id = (int)$_POST['sel_id'];

$anciennes_options = $base->meta_selection_entree_liste ($_SESSION['token'], $sel_id);
$anciens_sen = array ();

if ($_POST['options']) {
  $options = explode (';', $_POST['options']);
  $ordre = 1;
  if (count ($anciennes_options)) {
    foreach ($anciennes_options as $ancienne_option) {
      $anciens_sen[$ancienne_option['sen_id']] = 1;
    }
  }
  foreach ($options as $option) {
    if (substr ($option, 0, 4) == 'sen_') {
      $sen_id = substr ($option, 4);
      $base->meta_selection_entree_set_ordre ($_SESSION['token'], $sen_id, $ordre);    
      unset ($anciens_sen[$sen_id]);
    } else {
      $sen_id = $base->meta_selection_entree_add ($_SESSION['token'], $sel_id, '', $ordre);
    }
    $base->meta_selection_entree_set_libelle ($_SESSION['token'], $sen_id, $_POST['libelles'][$ordre-1]);
    $ordre++;
  }
}

if (count ($anciens_sen)) {
  foreach ($anciens_sen as $ancien_sen => $nil) {
    $base->meta_selection_entree_supprime ($_SESSION['token'], $ancien_sen);
  }
}

echo $sel_id;
?>

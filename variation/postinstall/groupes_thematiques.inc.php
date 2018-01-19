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
require_once ('../inc/common.inc.php');
$filename = $arrangement.'/arrangement/groupes_thematiques.csv';
// Convertit le fichier en UTF-8
$contenu = file_get_contents_detect ($filename);
$tempfile = tempnam(sys_get_temp_dir(), '');
file_put_contents ($tempfile, $contenu);

$f = fopen ($tempfile, 'r');
if (!$f)
  exit;
$entete = fgetcsv ($f, 0, "\t");

$groupes = array ();
while ( ($ligne = fgetcsv ($f, 0, "\t")) !== FALSE) {
  $nom = $ligne[0];
  $secteurs = array_map ('trim', explode (',', $ligne[1]));
  $groupes[$base->pour_code ($nom)] = array ('nom' => $nom, 'secteurs' => $secteurs);
}
?>

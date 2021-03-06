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
$cycle_statuts = array (1 => 'Demandé',
			2 => 'Accepté',
			3 => "Terminé",
			-1 => 'Refusé');

$statuts_usager = array (1 => "Sorti",
			 2 => "Pré-admission",
			 3 => "Admission",
			 4 => "Présent",
			 5 => "?");
$droits_parent = array (
    'appel' => 'Appel médiatisé',
    'courrier' => 'Courrier médiatisé',
    'rencontre' => 'Rencontre médiatisée',
    'visite' => 'Visite',
    'sortie' => 'Sortie et Visite',
    'hebergement' => 'Hébergement');
$doc_statut = array ('1' => 'À faire',
		     '2' => 'Demandé',
		     '3' => 'Existant');
$color_picker = array ("#F44336",
"#E91E63",
"#9C27B0",
"#673AB7",
"#3F51B5",
"#2196F3",
"#03A9F4",
"#00BCD4",
"#009688",
"#4CAF50",
"#8BC34A",
"#CDDC39",
"#FFEB38",
"#FFC107",
"#FF9800",
"#FF5722",
"#795548",
"#9E9E9E",
"#607D8B",
"#FFFFFF"
);
?>
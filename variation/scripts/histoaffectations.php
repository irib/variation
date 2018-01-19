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
<script>
$(document).ready(function () {
    $("#voirnoms").click(function() {
        $("#form").submit();
    });
});
</script>
<?php
include 'inc/enums.inc.php';

if (!$_POST['thedate']) {
    $_POST['thedate'] = date('d/m/Y');
}

$voirnoms = isset($_POST['voirnoms']);

$haf = $base->vues_histoaffectations_get($_SESSION['token'], $haf_id);
$grps = $base->groupe_affectation_liste($_SESSION['token'], $haf['inf_id'], $base->order('eta_nom, grp_nom'));
echo '<form method="POST" id="form" action="'.$_SERVER['REQUEST_URI'].'">';
echo '<span id="thedatespan" >';
echo '<input type="text" id="thedate" name="thedate" value="'.$_POST['thedate'].'" class="datepicker"></input>';
echo '</span>';

echo '<input type="submit" value="ok"></input>';
echo '<span style="float: right"><input type="checkbox" name="voirnoms" id="voirnoms"'.($voirnoms ? ' checked' : '').'><label for="voirnoms">Afficher les noms des usagers dans le tableau</label></span>';
echo '</form>';

echo '<table style="margin-top: 16px" class="tableliste"><tr><th align="left">Établissement<th align="left">Groupe<th align="right">Capacité';
echo '<th align="right">Affectations';

echo '</tr>';
display_at_date($grps, $_POST['thedate']);
echo '</table>';

function display_at_date($grps, $d) {
    global $cycle_statuts, $base, $voirnoms;
  foreach ($grps as $grp) {
    $n = $base->groupe_affectation_nombre_presents_a_date($_SESSION['token'], $grp['grp_id'], $d);
    $noms = $base->groupe_affectation_noms_presents_a_date($_SESSION['token'], $grp['grp_id'], $d);
    if ($n == 0)
      $theclass = 'italic';
    else 
      $theclass = '';    
    echo '<tr class="'.$theclass.'"><td>'.$grp['eta_nom'].'<td>'.$grp['grp_nom'];
    echo '<td align="right" valign="top">'.$grp['grp_capacite'];
    echo '<td align="right">';

    if ($n > 0) {
        if ($voirnoms) {
            echo $n.'<br>';
            affiche_noms($noms);
        } else {
            echo '<span title="';
            affiche_noms($noms);
            echo '" style="cursor: pointer; border-bottom: 1px dotted #777;" class="qtipable-bottom">'.$n;
            echo '</span>';
        }
    } else {
        echo '0';
    }
    echo '</tr>';
  }
}

function affiche_noms($noms) {
    foreach ($noms as $nom) {
        echo $nom."<br>";
    }    
}

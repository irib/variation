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
$aff = $base->vues_affectations_get($_SESSION['token'], $aff_id);
$grps = $base->groupe_affectation_liste($_SESSION['token'], $aff['inf_id'], $base->order('eta_nom, grp_nom'));

$voirnoms = isset($_POST['voirnoms']);

echo '<form method="POST" id="form" action="'.$_SERVER['REQUEST_URI'].'">';
echo '<input type="checkbox" name="voirnoms" id="voirnoms"'.($voirnoms ? ' checked' : '').'><label for="voirnoms">Afficher les noms des usagers dans le tableau</label>';
echo '</form>';
echo '<table style="margin-top: 16px" class="tableliste"><tr><th align="left">Établissement<th align="left">Groupe<th align="right">Capacité';
foreach ($cycle_statuts as $k => $statut) {
  echo '<th align="right">'.$statut;
}
echo '</tr>';
display_today($grps);
echo '</table>';

function display_today($grps) {
    global $cycle_statuts, $base, $voirnoms;
  foreach ($grps as $grp) {
    $n = array();
    $sum = 0;
    foreach ($cycle_statuts as $k => $statut) {
      $temp = $base->groupe_affectation_nombre_par_statut($_SESSION['token'], $grp['grp_id'], $k);
      $_noms = $base->groupe_affectation_noms_par_statut($_SESSION['token'], $grp['grp_id'], $k);
      $n[$k] = $temp[0]['n'];
      $noms[$k] = $_noms;
      $sum += $n[$k];
    }
    if ($sum == 0)
      $theclass = 'italic';
    else 
      $theclass = '';
    echo '<tr class="'.$theclass.'"><td valign="top">'.$grp['eta_nom'].'<td valign="top">'.$grp['grp_nom'];
    echo '<td align="right" valign="top">'.$grp['grp_capacite'];
    foreach ($cycle_statuts as $k => $statut) {
      echo '<td align="right" valign="top">';
      if ($n[$k] > 0) {
          if ($voirnoms) {
              echo $n[$k].'<br>';
              affiche_noms($noms[$k]);
          } else {
              echo '<span title="';
              affiche_noms($noms[$k]);
              echo '" style="cursor: pointer; border-bottom: 1px dotted #777;" class="qtipable-bottom">'.$n[$k];
              echo '</span>';
          }
      } else {
          echo '0';
      }
    }
    echo '</tr>';
  }
}

function affiche_noms($noms) {
    foreach ($noms as $nom) {
        echo $nom."<br>";
    }    
}

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


// EFFACER REQUIRE INUTILES
require '../PHPMailer-master/PHPMailerAutoload.php';
require '../inc/config.inc.php';
require '../inc/common.inc.php';
require '../inc/localise.inc.php';
require '../inc/enums.inc.php';
require '../inc/pgprocedures.class.php';
$base = New PgProcedures($pghost, $pguser, $pgpass, $pgbase);


if(!($base->droit_portail_get($_SESSION['token'], $_SESSION['portail'], 'envoi_mail'))){
    die('Envoi de mail desactivé.');
}

$dest = Array();
foreach ($_POST['prm_dests'] as $destinataire){
    $personne = $base->utilisateur_get_par_per_id($_SESSION['token'], $destinataire);
    if(!empty($personne['uti_email'])){
        $dest[] = $personne['uti_email'];
    }
}
foreach ($_POST['prm_destsaction'] as $destinataire){
    $personne = $base->utilisateur_get_par_per_id($_SESSION['token'], $destinataire);
    if(!empty($personne['uti_email'])){
        $dest[] = $personne['uti_email'];
    }
}

if(count($dest)==0){
    die("Aucun email n'est connu parmi la liste de destinataires !");
}

$usagers = Array();
foreach($_POST['prm_usagers'] as $usager){
    $usagers[] = $base->personne_get_libelle($_SESSION['token'], $usager);
}


if(count($usagers)==1){
    $titre_usager = "".$usagers[0].": ";
}else if(count($usagers)==2){
    $titre_usager = "".$usagers[0].", ".$usagers[1].": ";
}else {
    $titre_usager = "".$usagers[0].", ".$usagers[1].", ... : ";
}

if(!empty($_POST['prm_objet'])){
    $titre_mail = $_POST['prm_objet'];
}
else {
    $titre_mail = substr($_POST['prm_texte'], 0, 100);
}



$texte = '<meta http-equiv="content-type" content="text/html; charset=utf-8" />';

$texte .= "<b>".$_POST['prm_objet']."</b><br />";
$texte .= nl2br($_POST['prm_texte']);

$texte .= '
<br />==========================================
<br />';
$texte .= 'Dossier(s)';

foreach($usagers as $u){
    $texte.= "\n<br />- ".$u;
}
$url = "http://".$_SERVER['HTTP_HOST']."/";

$texte.="\n<br />";

$from = $base->utilisateur_get($_SESSION['token'], $_SESSION['uti_id']);
$name_from = $base->personne_get_libelle($_SESSION['token'], $from['per_id']);

$texte.="\n <br />Note soumise par ".$name_from;
$texte.="\n\n<br /><br /><a href='".$url."?boite'>Accéder à ma boîte de notes sur Variation</a>";

echo "SUJET:".$titre_usager.$titre_mail;
echo "\n\nMAIL:".$texte."\n";


$mail = new PHPMailer;
$mail->CharSet = 'UTF-8';

$mail->setFrom('ne-pas-repondre@variation.fr', 'Variation: Ne pas repondre');

foreach ($dest as $adr){
    $mail->addAddress($adr);
}

$mail->isHTML(true);
$mail->Subject = $titre_usager.$titre_mail;
$mail->Body = $texte;

if(!$mail->send()){
    echo "ERREUR ! ".$mail->ErrorInfo;
}
else{
    echo "Mail envoyé !";
}
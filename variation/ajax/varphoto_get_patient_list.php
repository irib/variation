<?php

header ('Content-Type: application/json ; charset=utf-8');
header ('Cache-Control: no-cache , private');
header ('Pragma: no-cache');

require ('../inc/config.inc.php');
require ('../inc/common.inc.php');
require ('../inc/pgprocedures.class.php');


$base = new PgProcedures ($pghost, $pguser, $pgpass, $pgbase);

if (!isset($_GET['token']))
  exit;
$token = (int)$_GET['token'];

$pers = $base->personne_liste_pour_varphoto($token);
echo json_encode($pers);

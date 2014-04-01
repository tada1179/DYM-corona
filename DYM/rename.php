<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$levelMax = 99;
$base_exp =84;

$user_id = $_GET["user_id"];
$user_name = $_GET["user_name"];

date_default_timezone_set('Asia/Bangkok');
echo $dateTime = date("Y-m-d H:i:s");

$updateStamina = mysql_query("UPDATE `user` set user_name = '$user_name' WHERE user_id = '$user_id'");


?>
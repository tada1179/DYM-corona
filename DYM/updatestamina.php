<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$levelMax = 99;
$base_exp =84;

$user_id = $_GET["user_id"];
$team_no = $_GET["team_no"];
$mission_stamina = $_GET["stamina"];


date_default_timezone_set('Asia/Bangkok');
echo $dateTime = date("Y-m-d H:i:s");


/*$sql = mysql_query("SELECT * FROM `user` WHERE user_id = '$user_id'");
$mysql = mysql_fetch_array($sql);
$mission_stamina = $mysql["user_power"] - $mission_stamina;*/

$update = mysql_query("UPDATE `team` set team_lastuse = '$dateTime' WHERE user_id = '$user_id' and team_no = '$team_no'");
$updateStamina = mysql_query("UPDATE `user` set user_power = '$mission_stamina' WHERE user_id = '$user_id'");


?>
<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$user_id = $_GET["user_id"];
$getPoint = $_GET["getPoint"];
$changePoint = $_GET["changePoint"];

if($getPoint == 'FriendPoint_OK'){
	$start = 1;
	$getPointToNum = 4;//FRIEND POINT
}else{
	$start = 4;
	$getPointToNum = 8;//DIAMOND POINT
}

$dataSQL = mysql_query("SELECT * FROM  `character` WHERE charac_rare BETWEEN '$start' and '$getPointToNum' order by rand() LIMIT 0 , 1");
$MydataSQL = mysql_fetch_array($dataSQL);

/*$dataINSERT = mysql_query("INSERT INTO `hold_character`
(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp)
VALUES('$user_id','$MydataSQL[charac_id]','$MydataSQL[charac_lvbase]','$MydataSQL[charac_att]','$MydataSQL[charac_def]','$MydataSQL[holdcharac_hp],'$MydataSQL[charac_exp]')");*/

$dataINSERT = mysql_query("INSERT INTO `hold_character`
(user_id,charac_id,holdcharac_lv,
holdcharac_att,holdcharac_def,holdcharac_hp, holdcharac_status)

VALUES('$user_id','$MydataSQL[charac_id]',
'$MydataSQL[charac_lvbase]','$MydataSQL[charac_att]',
'$MydataSQL[charac_def]','$MydataSQL[charac_hp]','1')");
if($start == 1){//FRIEND POINT
	$updateData = mysql_query("UPDATE user set user_FrientPoint = '$changePoint' WHERE user_id = '$user_id'");
}else{//DIAMOND POINT
	$updateData = mysql_query("UPDATE user set user_ticket = '$changePoint' WHERE user_id = '$user_id'");
}

$holdcharac =mysql_query("SELECT MAX(holdcharac_id) FROM  `hold_character`");
$Myholdcharac = mysql_fetch_array($holdcharac);

$missionAll["character_id"]=$Myholdcharac["MAX(holdcharac_id)"];

$userMy  = mysql_query("SELECT * FROM user WHERE user_id = '$user_id'");
$mysqlUser = mysql_fetch_array($userMy);

$missionAll["ticket"]=$mysqlUser["user_ticket"];
$missionAll["FrientPoint"]=$mysqlUser["user_FrientPoint"];

echo json_encode($missionAll); 
?>
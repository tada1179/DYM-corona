<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$macCharacter = 5;


$team_id = $_GET["team_id"];
$charac_id = $_GET["charac_id"];
$holdteam_no = $_GET["holdteam_no"];
$user_id = $_GET["user_id"];

$teamUser = mysql_query("SELECT * FROM team where team_no = '$team_id' and user_id = '$user_id'");
$myteamUser = mysql_fetch_array($teamUser);

$dataL = mysql_query("SELECT * FROM hold_team
WHERE team_id = '$myteamUser[team_id]' and holdteam_no = '$holdteam_no'");
$rowL = mysql_num_rows($dataL);

	if($rowL){
		$data = mysql_query("UPDATE hold_team
		SET holdcharac_id = '$charac_id'
		WHERE team_id = '$myteamUser[team_id]' and holdteam_no = '$holdteam_no'");
		echo "if rowsl";
	}
	else{
			//$rowL ++;
			
			$data = mysql_query("INSERT INTO hold_team
			(team_id,holdcharac_id,holdteam_no)
			VALUES('$myteamUser[team_id]','$charac_id','$holdteam_no')");
			echo "else rowsl";
		}


?>
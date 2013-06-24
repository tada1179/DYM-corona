<?php
//USE IN SHOW in page teamView  ==> team_main.lua

include("include/connect.php");
$macCharacter = 5;


$team_no = $_GET["team_no"];
$user_id = $_GET["user_id"];


	$data = mysql_query("SELECT team . * , hold_team . * 
	FROM  `team` 
	LEFT JOIN hold_team 
	ON team.team_id = hold_team.team_id
	AND team.user_id = $user_id
	WHERE team.team_id = $team_no");
	while($mydata = mysql_fetch_array($data)){
		mysql_query("DELETE FROM hold_team where holdteam_id = '$mydata[holdteam_id]'
		and holdteam_no != 1 ");
		}

?>
<?php
//USE IN SHOW in page discharge  ==> alertmassage.lua
include("include/connect.php");

$holdcharac_id = $_GET["character"];
$user_id = $_GET["user_id"];

$hdchr_user =mysql_query("SELECT hold_character.* , user. user_id 
	FROM  `hold_character` 
	INNER JOIN  `user` ON hold_character.user_id = user.user_id
	and hold_character.holdcharac_id = '$holdcharac_id'
	where user.user_id = '$user_id'
	");
	
	while($mydata = mysql_fetch_array($hdchr_user)){
		mysql_query("DELETE FROM hold_character where holdcharac_id = '$mydata[holdcharac_id]'");
		}

?>
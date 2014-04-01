<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
for ($i = 15;52;$i++){
	$data = mysql_query("SELECT * FROM `skill` WHERE skill_id = '$i'");
	$mydata = mysql_fetch_array($data);
	$ii = $i +1;
	mysql_query("UPDATE `skill` SET skill_detail = '$mydata[skill_detail]' WHERE skill_id = '$ii'");
	echo "<br />$i";
}
	
?>
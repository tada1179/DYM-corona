<?php
include("include/connect.php");

$SysdeviceID = $_GET["deviceID"];

$sql = "SELECT `user_name` FROM `user` WHERE  user_udid = '$SysdeviceID' order by user_lastlogin DESC";    //replace with your table name 
$result = mysql_query($sql); 
$result = mysql_result($result,0);


if(isset($result))
{
	echo "OLD";
}else{
	echo "NEW";
}
	
?>

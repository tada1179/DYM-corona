<?php
$host="localhost";
$user="root";
$pass="";
//$db="GAME";
$db="puzzle";
$connect = mysql_connect($host,$user,$pass);
mysql_query("SET NAMES UTF8",$connect); // เอาไว้กรณีให้บังคับตัวหนังสือเป็น UTF 8
mysql_select_db($db);
	
?>

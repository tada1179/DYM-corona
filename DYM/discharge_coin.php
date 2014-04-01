<?php
//USE IN SHOW in page discharge  ==> alertmassage.lua
include("include/connect.php");

$coin = $_GET["coin"];
$user_id = $_GET["user_id"];

$hdchr_user =mysql_query("SELECT * FROM `user` where user.user_id = '$user_id'");
	
	while($mydata = mysql_fetch_array($hdchr_user)){
		$coinNew = $mydata["user_coin"] + $coin; 
		
		mysql_query("UPDATE user SET user_coin = '$coinNew' where user_id = '$user_id'");
		}

?>
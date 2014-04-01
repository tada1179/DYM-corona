<?php
//#use team item.lua
include("include/connect.php");

$myuser_id = $_GET["user_id"];
$max = $_GET["maxStatmina"];

$hdchr_user =mysql_query("SELECT * from user where user_id = '$myuser_id'");

while($myhdchr_user = mysql_fetch_array($hdchr_user)){
	if ( $myhdchr_user["user_ticket"] != 0 ){
		$numstamina = $max;
		$num_diamond = $myhdchr_user["user_ticket"]-1;
		$update = mysql_query("UPDATE user 
		set user_power = '$numstamina',
		user_ticket = '$num_diamond' 
		where user_id = '$myuser_id'
		");
	}
	
}
$mhdchr_user =mysql_query("SELECT * from user where user_id = '$myuser_id'");
while($myuser = mysql_fetch_array($mhdchr_user)){
	$staminaHold = $myuser["user_power"];
	$Coin = $myuser["user_ticket"];
}
$json_row["stamina"] = $staminaHold;
$json_row["Coin"] = $Coin;
echo json_encode($json_row); 


?>

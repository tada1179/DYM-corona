<?php
//#use team item.lua
include("include/connect.php");

$myuser_id = $_GET["user_id"];

$hdchr_user =mysql_query("SELECT * from user where user_id = '$myuser_id'");

while($myhdchr_user = mysql_fetch_array($hdchr_user)){
	if ( $myhdchr_user["user_ticket"] != 0 ){
		$numslot = $myhdchr_user["user_deck"]+5;
		$num_diamond = $myhdchr_user["user_ticket"]-1;
		
		$update = mysql_query("UPDATE user 
		set user_deck = '$numslot',
		user_ticket = '$num_diamond' 
		where user_id = '$myuser_id'
		");
	}
	
}
$mhdchr_user =mysql_query("SELECT * from user where user_id = '$myuser_id'");
while($myuser = mysql_fetch_array($mhdchr_user)){
	$slotHold = $myuser["user_deck"];
	$Coin = $myuser["user_ticket"]; 
}
$json_row["slot"] = $slotHold;
$json_row["Coin"] = $Coin;
echo json_encode($json_row); 

?>

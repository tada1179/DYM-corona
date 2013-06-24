<?php
//#USER FN confrimLeaveTicket.lua = alertMassage

include("include/connect.php");
$user_id = $_GET["user_id"];
$NumFlag = $_GET["NumFlag"];//NO update
$NumDiamond = $_GET["NumDiamond"];
$NumCoin = $_GET["NumCoin"];
$NumEXP = $_GET["NumEXP"];

$data = mysql_query("SELECT * FROM user WHERE user_id = '$user_id'")or die("LEAVEL Ticket:".mysql_error());
if($mydata = mysql_fetch_array($data)){
	$myCoin = $mydata["user_coin"];
	$newCoin = $myCoin + $NumCoin; 
	
	$myDiamond  = $mydata["user_ticket"]-1;
	$newDiamond = $myDiamond + $NumDiamond; 
	
	$myExp = $mydata["user_exp"];
	$newExp = $myExp + $NumEXP; 
	
	}
		$insert = mysql_query("UPDATE user SET 
		user_coin = '$newCoin' ,
		user_ticket = '$newDiamond',
		user_exp = '$newExp'
		WHERE user_id = '$user_id'");
	//}


?>

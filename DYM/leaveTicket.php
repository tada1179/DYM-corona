<?php
//#USER FN confrimLeaveTicket.lua = alertMassage

include("include/connect.php");
$user_id = $_GET["user_id"];
$NumFlag = $_GET["NumFlag"];//NO update
$NumDiamond = $_GET["NumDiamond"];
$NumCoin = $_GET["NumCoin"];
$NumEXP = $_GET["NumEXP"];

if($NumFlag >0){
	$cha = "SELECT * FROM character ";
	for($i=1; $i<=$NumFlag ;$i++){
		$ch = $_GET["charac$i"];
		
		$cha = $cha."WHERE charac_id = '$ch'";
		$cha = mysql_query($cha);
		
		$insert = mysql_query("INSERT INTO hold_character VALUES('$user_id','$cha[charac_id]','$cha[charac_lvbase]'
		,'$cha[charac_att]','$cha[charac_def]','$cha[charac_hp]',0,1)");
	}
}
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
$json["coin"] = $newCoin;
$json["ticket"] = $newDiamond;
$json["exp"] = $newExp;	

echo json_encode($json); 

?>

<?php
include("include/connect.php");

$SysdeviceID = $_GET["SysdeviceID"];

$sql = "SELECT * FROM `user` WHERE  user_udid = '$SysdeviceID' order by user_lastlogin DESC";    //replace with your table name 
$result = mysql_query($sql); 
$json = array(); 
$count=0; 

	if(mysql_num_rows($result)){ 
		while($myuser=mysql_fetch_array($result)) { 
			$count = $count+1; 
			$json["deviceID".$count]= array(
			"user_id"=>$myuser["user_id"],
			"user_name"=>$myuser["user_name"], 
			"user_type"=>$myuser["user_type"], 
			"user_coin"=>$myuser["user_coin"],
			"user_ticket"=>$myuser["user_ticket"], 
			"user_power"=>$myuser["user_power"], 
			"user_deck"=>$myuser["user_deck"],
			"user_level"=>$myuser["user_level"]      
			);
		} 
		
		/*while($row=mysql_fetch_row($result)) { 
			$count = $count+1; 
			$json["deviceID".$count]=$row; 
		} */
	} 

echo json_encode($json); 
	
?>

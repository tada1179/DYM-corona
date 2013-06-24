<?php
//@ mission.lua
include("include/connect.php");

$user_id = $_GET["user_id"];
$user_Lv = $_GET["user_Lv"];

$sql = mysql_query("SELECT state.*, state_user.*
FROM state  LEFT join state_user on(state.state_id = state_user.state_id)
WHERE state_level <= '$user_Lv' ORDER BY  `state_user`.`stateuser_pass` ASC 
");   
 //replace with your table name 
$json_row = array(); 
$json_row["All"] = mysql_num_rows($sql);

	if(mysql_num_rows($sql)){ 
	
		while($myuser = mysql_fetch_array($sql)) { 
			if($myuser["stateuser_pass"]){
				$clear = 2;//ผ่านด่านแล้ว
			}else{
				$clear = 1;//ยังไม่ผ่านด่าน mission
			}
		
			$json[] = array(
			"mission_id"	=>	$myuser["state_id"],
			"mission_name"	=>	$myuser["state_name"], 
			"mission_lv"	=>	$myuser["state_level"], 
			"mission_no"	=>	$myuser["state_no"],
			"mission_amount"=>	$myuser["state_amount"], 
			"mission_img"	=>	$myuser["state_img"] ,
			"ID_clear"  	=>  $clear 
			);
		} 
	} 
$json_row["state"] = $json;
echo json_encode($json_row); 
	
?>

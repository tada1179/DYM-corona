<?php
//@ mission.lua
include("include/connect.php");

$user_id = $_GET["user_id"];
$chapter_id = $_GET["chapter_id"];
$row_count = 0;

	$sql = mysql_query("SELECT * 
	FROM `mission`
	where `mission`.chapter_id = '$chapter_id'
	ORDER BY chapter_id ASC"); 
	$rowChapter = mysql_num_rows($sql);
	$row_new = 1;
	$ch_id = 0;
	while($chapter = mysql_fetch_array($sql)) { 
		if($row_new==1){
			
			$sqlmission = mysql_query("SELECT * FROM `user_mission` where user_id = '$user_id' and usermission_id ='$chapter[mission_id]' ORDER BY usermission_id ASC ");  
			$user_mission = mysql_num_rows($sqlmission);
			
			$character = mysql_query("SELECT * FROM `character` where charac_id = '$chapter[mission_boss_id]'");  
			$mycharacter = mysql_fetch_array($character);

			
			if($user_mission){//มีข้อมูลการผ่านมิชชั้นนั้นแล้ว
				$status = "clear";
			}else{
				$status = "new";
				$row_new = 2;
			}
			$row_count++;
			$json[] = array(
	
			"mission_id"	=>	$chapter["mission_id"] ,
			"mission_name"	=>	$chapter["mission_name"] ,
			"mission_img"	=>	$chapter["mission_img"] ,
			"mission_img_boss"	=>	$mycharacter["charac_img_mini"] ,
			"mission_boss_element"	=>	$mycharacter["charac_element"] ,
			"mission_stamina"	=>	$chapter["mission_stamina"] ,
			"mission_run"	=>	$chapter["mission_run"] ,
			"characterNum"	=>	$chapter["mission_characterNum"] ,
			"ID_clear"  	=>  $status  
			);
		}
	}
$json_row = array(); 
$json_row["All"] = $row_count; 
$json_row["mission"] = $json;
echo json_encode($json_row); 
	
?>

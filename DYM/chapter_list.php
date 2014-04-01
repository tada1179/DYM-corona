<?php
//@ mission.lua
include("include/connect.php");

$user_id = $_GET["user_id"];
$map_id = $_GET["map_id"];
$row_count = 0;

	$sql = mysql_query("SELECT * 
	FROM `chapter`
	where `chapter`.map_id = '$map_id'
	ORDER BY chapter_id ASC"); 
	$rowChapter = mysql_num_rows($sql);
	$row_new = 1;
	$ch_id = 0;
	while($chapter = mysql_fetch_array($sql)) { 
		if($row_new==1 and $ch_id != $chapter["chapter_id"]){
			$sqlmission = mysql_query("SELECT * FROM `user_mission` 
			where user_id = '$user_id' 
			and chapter_id ='$chapter[chapter_id]' 
			ORDER BY usermission_id ASC ");  
			
			$user_mission = mysql_num_rows($sqlmission);
			if($user_mission==$chapter["chapter_mission_run"]){//มีข้อมูลการผ่านมิชชั้นนั้นแล้ว
				$status = "clear";
				$ch_id = $chapter["chapter_id"];
			}else{
				$status = "new";
				$row_new = 2;
			}
			$row_count++;
			$json[] = array(
			"chapter_mission_run"	=>	$chapter["chapter_mission_run"] ,
			"chapter_name"	=>	$chapter["chapter_name"] ,
			"chapter_id"	=>	$chapter["chapter_id"] ,
			"ID_status"  	=>  $status 
			);
		}
	}
$json_row = array(); 
$json_row["All"] = $row_count; 
$json_row["chapter"] = $json;
echo json_encode($json_row); 
	
?>

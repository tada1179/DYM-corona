<?php
//#use team item.lua
include("include/connect.php");

$team_id = $_GET["team_id"];
$myuser_id = $_GET["user_id"];
$team_no = mysql_query("SELECT * FROM team where team_no = '$team_id' and user_id = '$myuser_id'");
$myteamNo = mysql_fetch_array($team_no);

$hdchr_user =mysql_query("SELECT hold_character.*,hold_team.holdteam_id
						FROM `hold_character`
						LEFT join hold_team 
						on hold_character.holdcharac_id = hold_team.holdcharac_id 
						AND hold_team.team_id = '$myteamNo[team_id]'
						where hold_character.user_id = '$myuser_id' 
						and `hold_character`.holdcharac_status = '1'
			");
			
	$json1 = array(); 	
	$numChr = mysql_num_rows($hdchr_user);
	$json1["chrAll"]=$numChr; 	
						
while($myhdchr_user = mysql_fetch_array($hdchr_user)){
	//print("myhdchr_user = ".$myhdchr_user["holdteam_id"]);
		if ($myhdchr_user["holdteam_id"]!= NULL){
			$use = 1; // มีข้อมูลการเรียกใช้งานแล้ว
		}else{
			$use = NULL; // ยังไม่มีการเรียกใช้งาน
		}
		$chrdatd = mysql_query("SELECT * FROM `character` 
		WHERE charac_id = '$myhdchr_user[charac_id]'");
		$count = $count+1;	
		while($rs=mysql_fetch_array($chrdatd)){  
			$json[]=array(  
			"holdcharac_id"=>$myhdchr_user['holdcharac_id'],  
        	 "charac_id"=>$rs['charac_id'],  
       		 "charac_name"=>$rs['charac_name'], 
			 "charac_atk"=>$myhdchr_user['holdcharac_att'],  
			 "charac_def"=>$myhdchr_user['holdcharac_def'],  
			 "charac_hp"=>$myhdchr_user['holdcharac_hp'], 
			 "charac_lv"=>$myhdchr_user['holdcharac_lv'],   
			 "charac_element"=>$rs['charac_element'],  
			 "charac_img_mini"=>$rs['charac_img_mini'], 
			 "charac_img"=>$rs['charac_img'],   
			 "leader_id"=>$rs['leader_id'],  
			 "pwextra_id"=>$rs['pwextra_id'],
			  "myhdchr_user"=>$myhdchr_user['holdteam_id'],
			 "use_id"=>$use        
    		);		
		}
		
}
$json1["chracter"]=$json;
echo json_encode($json1); 
	
?>

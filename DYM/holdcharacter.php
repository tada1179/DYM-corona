<?php
//#USER team_select.lua
include("include/connect.php");
$holdcharac_id = $_GET["charac_id"];

$chrdatd = mysql_query("SELECT * FROM `hold_character` 
WHERE holdcharac_id = '$holdcharac_id'");

while($myhdchr_user = mysql_fetch_array($chrdatd)){
	
		//if($charac_id == $myhdchr_user["holdcharac_id"]){
			$charc = mysql_query("SELECT * FROM `character` 
			WHERE charac_id = '$myhdchr_user[charac_id]'");
			$count = $count+1;						
				while($rs=mysql_fetch_array($charc)){  
					$json[]=array(  					 
					 "holdcharac_id"=>$holdcharac_id,  
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
					 "skill_id"=>$rs['skill_id'],        
					);	
				}
			//}
	
	}
//$json1["chracter"]=$json;
echo json_encode($json); 
?>
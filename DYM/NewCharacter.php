<?php
//#USER Team_item.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$holdcharac_id = $_GET["character"];

$hdchr_hdteam = mysql_query("SELECT hold_character . * , hold_team . * 
	FROM  `hold_character` 
	INNER JOIN  `hold_team` 
	ON hold_character.holdcharac_id = hold_team.holdcharac_id");
	
$hdchr_user =mysql_query("SELECT hold_character.* , user. user_id ,
 user. user_name ,
 user. user_level 
	FROM  `hold_character` 
	INNER JOIN  `user` ON hold_character.user_id = user.user_id
	and hold_character.holdcharac_id = '$holdcharac_id'
	where user.user_id = '$myuser_id'
	");

	$json1 = array(); 	
	$numChr = mysql_num_rows($hdchr_user);
	$json1["All"]=$numChr; 
	$i = 0;	
	$count=0; 
while($myhdchr_user = mysql_fetch_array($hdchr_user)){
	
		//if($charac_id == $myhdchr_user["holdcharac_id"]){
			$chrdatd = mysql_query("SELECT * FROM `character` 
			WHERE charac_id = '$myhdchr_user[charac_id]'");
			$count = $count+1;						
				while($rs=mysql_fetch_array($chrdatd)){  
					$json[]=array(  
					 
					 "user_id"=>$myhdchr_user['user_id'], 
					 "user_Name"=>$myhdchr_user['user_name'], 
					 "user_LV"=>$myhdchr_user['user_level'], 
					 
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
					 "pwextra_id"=>$rs['pwextra_id'],        
					);	
				}
			//}
	
	}
$json1["chracter"]=$json;
echo json_encode($json1); 

?>

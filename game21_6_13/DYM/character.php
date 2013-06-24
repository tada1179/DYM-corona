<?php
	//#use character_scene.lua
	//#use characterAll.lua
//-------------------------------------//
include("include/connect.php");

$charac_id = $_GET["character"];
$myuser_id = $_GET["user_id"];

$hdchr_user =mysql_query("SELECT hold_character.* ,
	user.user_name,
	user.user_level
	FROM  `hold_character` 
	INNER JOIN  `user` ON hold_character.user_id = user.user_id
	where user.user_id = '$myuser_id'
	and hold_character.charac_id = '$charac_id'");
while($myhdchr_user = mysql_fetch_array($hdchr_user)){
		
		$chrdatd = mysql_query("SELECT * FROM `character` 
		WHERE charac_id = '$myhdchr_user[charac_id]'");
		$count = $count+1;	
		while($rs=mysql_fetch_array($chrdatd)){  
			$json[]=array(  
			"user_id"=>$myhdchr_user['user_id'], 
			"user_Name"=>$myhdchr_user['user_name'], 
			"user_LV"=>$myhdchr_user['user_level'], 
			
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
		
}
$json1["chracter"]=$json;
echo json_encode($json1); 
	
?>

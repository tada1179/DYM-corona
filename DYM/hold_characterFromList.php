<?php
//#USER Team_item.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$NumFlag = $_GET["NumFlag"];

$json1["chrAll"]=$NumFlag; 
for($i=1; $i<=$NumFlag; $i++){
  $charac_id = $_GET["character_id$i"];
	
	$hdchr_hdteam = mysql_query("SELECT `hold_character`.*,`character` .*
	FROM  `hold_character` inner join `character` 
	on(`character`.charac_id = `hold_character`.charac_id ) 
	where `hold_character`.user_id = '$myuser_id' 
	and `hold_character`.charac_id= '$charac_id'
	ORDER BY `hold_character`.`holdcharac_id`  DESC limit 0,1");
	$row = mysql_num_rows($hdchr_hdteam);
	
	if($row > 0){
		
		$mySQL = mysql_fetch_array($hdchr_hdteam);
		$json[]=array(  
			 "holdcharac_id"=>$mySQL['holdcharac_id'],  
        	 "charac_id"=>$mySQL['charac_id'],  
       		 "charac_name"=>$mySQL['charac_name'], 
			 "charac_sac"=>$mySQL['charac_sac'],
			 "charac_lvmax"=>$mySQL['charac_lvmax'],  
			 "charac_atk"=>$mySQL['holdcharac_att'],  
			 "charac_def"=>$mySQL['holdcharac_def'],  
			 "charac_hp"=>$mySQL['holdcharac_hp'], 
			 "charac_lv"=>$mySQL['holdcharac_lv'],
			 "charac_exp"=>$mySQL['holdcharac_exp'],    
			 "charac_element"=>$mySQL['charac_element'],  
			 "charac_img_mini"=>$mySQL['charac_img_mini'], 
			 "charac_img"=>$mySQL['charac_img'],          
			 );
		
		}
}

$json1["character"]=$json;
echo json_encode($json1); 

?>

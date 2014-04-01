<?php
//#USER Team_item.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];

$charac = mysql_query("SELECT * FROM `character` order by charac_no");

$json1 = array(); 	
$numChr = mysql_num_rows($charac);
$json1["chrAll"]=$numChr; 

while($mycharac = mysql_fetch_array($charac)){
	$hold =mysql_query("SELECT * FROM `hold_character`
	where user_id = '$myuser_id' and charac_id = '$mycharac[charac_id]'
	GROUP BY  charac_id 
	ORDER BY `hold_character`.`holdcharac_status`  DESC");
	$myhold = mysql_fetch_array($hold);
	$rowHold = mysql_num_rows($hold); 
	
	if($rowHold){
		if($myhold["holdcharac_status"]==1){
			$use = 1;
		}else{
			$use = 2;
		}
		$holdcharac_id = $myhold["holdcharac_id"];
	}else{
		$use = 1110;
		$holdcharac_id = 1110;
	}
	
	$json[]=array(    
			 "holdcharac_id"   => $holdcharac_id,
        	 "charac_id"       => $mycharac['charac_id'],  
       		 "charac_name"     => $mycharac['charac_name'],    
			 "charac_element"  => $mycharac['charac_element'],  
			 "charac_img_mini" => $mycharac['charac_img_mini'], 
			 "charac_no" => $mycharac['charac_no'], 
			 "use" => $use,       
    		);				
}

$json1["chracter"]=$json;
echo json_encode($json1); 

?>

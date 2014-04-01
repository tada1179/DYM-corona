<?php
//USE IN SHOW TEAM IN PAGE TEAM_SETTING FILE ==> TEAM1,..,TEAM5.LUA

include("include/connect.php");

$user_id = $_GET["user_id"];
$team_no = $_GET["team_no"];

$data = mysql_query("SELECT  `team`. * ,  `hold_team`. * 
FROM  `team` 
INNER JOIN  `hold_team` ON  `team`.team_id =  `hold_team`.team_id
and `team`.team_no = $team_no 
where `team`.user_id = $user_id 
order by `hold_team`.holdteam_no
");
//
$json1 = array(); 
$count = 0;

while($rowchrdatd=mysql_fetch_array($data)) { 	
//print("holdcharac_id:".$rowchrdatd["holdcharac_id"]."<br />");

	$hdchr_user =mysql_query("SELECT `hold_character`.* , 
	`character`.charac_img,
	`character`.charac_name,
	`character`.skill_id,
	`character`.charac_skill,
	`character`.leader_id, 
	`character`.charac_leader,  
	`character`.charac_cost ,
	`character`.charac_img_mini ,
	`character`.charac_element,
	`character`.charac_def,
	`character`.charac_att, 
	`character`.charac_hp
	FROM  `hold_character` 
	INNER JOIN  `character` ON `hold_character`.charac_id = `character`.`charac_id`
	where `hold_character`.holdcharac_id = '$rowchrdatd[holdcharac_id]' and `hold_character`.holdcharac_status = '1'
	");	
	
	 
	//$json1["holdteam".$count] = $rowchrdatd["holdteam_no"];

	while($Img=mysql_fetch_array($hdchr_user)) { 
			
		$json[]=array(
		"holdcharac_id"=>$rowchrdatd["holdcharac_id"],
		"team_no"=>$rowchrdatd["holdteam_no"],
		"charac_name"=>$Img["charac_name"],
		"charac_skill"=>$Img["charac_skill"],
		"charac_leader"=>$Img["charac_leader"],
		
		"img"=>$Img["charac_img"],
		"cost"=>$Img["charac_cost"],
		"holdcharac_lv"=>$Img["holdcharac_lv"],
		"imgMini"=>$Img["charac_img_mini"],
		"element"=>$Img["charac_element"],
		"def"=>$Img["charac_def"],
		"atk"=>$Img["charac_att"],
		"hp"=>$Img["charac_hp"],
		"leader_id"=>$Img["leader_id"],
		"skill_id"=>$Img["skill_id"],
		
		
		);
		$count ++;
	}

}  
$json1["chrAll"]=$count;	
$json1["chracter"]=$json;

echo json_encode($json1); 
	
	
?>

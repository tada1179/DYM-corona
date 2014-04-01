<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$mission_id = $_GET["mission_id"];

$count = "1" ;
$mission_coin = mysql_query("SELECT * FROM mission WHERE mission_id = '$mission_id'");
$Mymission_coin = mysql_fetch_array($mission_coin);

$mis_run = mysql_query("SELECT * FROM mission_run WHERE mission_id = '$mission_id' order by mission_id ASC");
$allRow = mysql_num_rows($mis_run);
$missionAll["battleAll"]=$allRow;
$missionAll["missionCoin"]=$Mymission_coin["mission_coin"];

$mission = array();
while($mymis_run = mysql_fetch_array($mis_run)){	
//echo  "$count -- $allRow<br />";
	$battle = $count.$allRow;
	if($allRow == $count){
		$dataM = mysql_query("SELECT  `mission` . * ,  `target` . * 
	FROM  `mission` 
	INNER JOIN  `target` ON ( mission.mission_id = target.mission_id ) 
	WHERE  `target`.mission_id = '$mission_id' and `target`.target_status = '1' order by target_id LIMIT 0 , $mymis_run[numCharacterBattle]");
	//target_status, 2 = character,1=boss
	$target_status = 1;
		}else{
		$dataM = mysql_query("SELECT  `mission` . * ,  `target` . * 
	FROM  `mission` 
	INNER JOIN  `target` ON ( mission.mission_id = target.mission_id ) 
	WHERE  `target`.mission_id = '$mission_id' and `target`.target_status = '2' order by rand() LIMIT 0 , $mymis_run[numCharacterBattle]");
	//target_status, 2 = character,1=boss
	$target_status = 2;
		}
	
	$rowCh = mysql_num_rows($dataM);
	$friend_list = array();
	$dataJson = array();
	$friend_list["battle"] = $count;	
	$friend_list["battle_id"] = $battle;	
	$friend_list["characAll"] = $rowCh;
	while($mydata_mission = mysql_fetch_array($dataM)){
		$charac = mysql_query("SELECT * FROM `character` where `charac_id` = '$mydata_mission[character_id]'");
		$mycharac = mysql_fetch_array($charac);
		
		$con = mysql_query("SELECT `target`.* ,`condition`.* 
		FROM `target` inner join `condition`
		on(`target`.condition_id = `condition`.condition_id)
		WHERE `target`.character_id = '$mydata_mission[character_id]' 
		and `target`.mission_id = '$mydata_mission[mission_id]'
		and `target`.target_status = '$target_status'");
		$mycondition = mysql_fetch_array($con);
		
		$dataJson[] = array( 
		"charac_id"=>$mycharac['charac_id'],
		"charac_name"=>$mycharac['charac_name'],
		"charac_img"=>$mycharac['charac_img'],
		"charac_element"=>$mycharac['charac_element'],
		"charac_hp"=>$mycharac['charac_hp'],
		"charac_def"=>$mycharac['charac_def'],
		"charac_atk"=>$mycharac['charac_att'],
		"charac_spw"=>$mycharac['charac_spw'],
		"charac_sph"=>$mycharac['charac_sph'],
		"charac_countD"=>$mycharac['charac_count_defense'],
		"charac_coin"=>$mycharac['charac_sell'],
		"condition"=>$mycondition['condition_hp'],
		); 
		$friend_list["charcac"] = $dataJson;
		
	}
	
	
	
	$mission[] = array(
	"mission" => $friend_list);
	$missionAll["one"] = $mission;
	$count++;

}
	echo json_encode($missionAll); 
?>
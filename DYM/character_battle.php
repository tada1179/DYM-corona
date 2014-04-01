<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");

$user_id = $_GET["user_id"];
$character_numAll = $_GET["character_numAll"];

$dataL = mysql_query("SELECT * FROM `character`");

$row = mysql_num_rows($dataL);

$friend_list = array();	
$friend_list["All"] = $character_numAll;

for ($i = 1 ; $i <= $character_numAll; $i++){
	//$numrand_id = rand(1,30); 	character tu + bew
	$numrand_id = rand(1,$row);
	if ($character_numAll != 1 and $numrand_id == 6){
		$numrand_id ++;
		}
		//$numrand_id = 53;
	$charac = mysql_query("SELECT * FROM `character` where `charac_id` = '$numrand_id'");
	$mycharac = mysql_fetch_array($charac);
	
	$dataJson[]=array( 
	"charac_id"=>$mycharac['charac_id'],
	"charac_name"=>$mycharac['charac_name'],
	"charac_img"=>$mycharac['charac_img'],
	"charac_element"=>$mycharac['charac_element'],
	"charac_spw"=>$mycharac['charac_spw'],
	"charac_sph"=>$mycharac['charac_sph'],
	); 
	
	}
$friend_list["character"]=$dataJson;
echo json_encode($friend_list); 
?>
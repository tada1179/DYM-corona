<?php
//@ mission.lua
include("include/connect.php");

$user_id = $_GET["user_id"];
$row_new=1;

	$sql = mysql_query("SELECT  `mission` . * , `user_mission`.user_id ,
		`user_mission`.usermission_id,`user_mission`.user_mission_id
		FROM  `mission` 
		LEFT JOIN  `user_mission` 
		ON (  `mission`.mission_id = `user_mission`.usermission_id
		AND  `user_mission`.user_id = '$user_id' ) 
		ORDER BY  `mission`.`mission_id` ASC"); 
		
	while($chapter = mysql_fetch_array($sql)) { 
	$map = mysql_query("SELECT * FROM chapter WHERE chapter_id = '$chapter[chapter_id]'");
	$mymap = mysql_fetch_array($map);
	
	$miss = mysql_query("SELECT `mission`.* ,`character`.*
	FROM `mission` INNER JOIN `character`
	on(`character`.charac_id = `mission`.mission_boss_id)
	where `mission`.chapter_id = '$chapter[chapter_id]'
	and `mission`.mission_id = '$chapter[mission_id] '
	ORDER BY chapter_id ASC"); 
	$mycharacter = mysql_fetch_array($miss);
						
			
	
		if($chapter["user_id"] == NULL and $row_new==1){
			$status = "new";
			$row_new = 2;
			$row_count ++;
			$json[] = array(
			"chapter_mission_run"	=>	$mymap["chapter_mission_run"] ,
			
			"mission_id"	=>	$chapter["mission_id"] ,
			"chapter_id"	=>	$chapter["chapter_id"] ,
			"chapter_name"	=>	$mymap["chapter_name"] ,
			"map_id"		=>	$mymap["map_id"],
			"ID_status"  	=>  $status ,
			
			"mission_name"	=>	$mycharacter["mission_name"] ,
			"mission_img"	=>	$mycharacter["mission_img"] ,
			"mission_img_boss"	=>	$mycharacter["charac_img_mini"] ,
			"mission_boss_element"	=>	$mycharacter["charac_element"] ,
			"mission_stamina"	=>	$mycharacter["mission_stamina"] ,
			"mission_run"	=>	$mycharacter["mission_run"] ,
			"characterNum"	=>	$mycharacter["mission_characterNum"] ,
			);
			
		}else{
			$status = "clear";
			$ch_id = $chapter["chapter_id"];
		}
		if($row_new==1 and $user_id["user_id"]){
			$row_count ++;
			$json[] = array(
			"chapter_mission_run"	=>	$mymap["chapter_mission_run"] ,
			
			"mission_id"	=>	$chapter["mission_id"] ,
			"chapter_id"	=>	$chapter["chapter_id"] ,
			"chapter_name"	=>	$mymap["chapter_name"] ,
			"map_id"		=>	$mymap["map_id"],
			"ID_status"  	=>  $status ,
			
			"mission_name"	=>	$mycharacter["mission_name"] ,
			"mission_img"	=>	$mycharacter["mission_img"] ,
			"mission_img_boss"	=>	$mycharacter["charac_img_mini"] ,
			"mission_boss_element"	=>	$mycharacter["charac_element"] ,
			"mission_stamina"	=>	$mycharacter["mission_stamina"] ,
			"mission_run"	=>	$mycharacter["mission_run"] ,
			"characterNum"	=>	$mycharacter["mission_characterNum"] ,
			);
		}
	}
$json_row = array(); 
$json_row["All"] = $row_count; 
$json_row["chapter"] = $json;
echo json_encode($json_row); 
	
?>

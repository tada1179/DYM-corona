<?php
//@ mission.lua
include("include/connect.php");
$mission_id = $_GET["mission_id"];

	$sql = mysql_query("SELECT  `mission` . * ,  `chapter` . * 
		FROM  `mission` 
		INNER JOIN  `chapter` ON (`chapter`.chapter_id =  `mission`.chapter_id ) 
		WHERE  `mission`.mission_id =  '$mission_id'"); 
	while($chapter = mysql_fetch_array($sql)) { 					
			$json[] = array(	
			"mission_id"	=>	$chapter["mission_id"] ,
			"mission_name"	=>	$chapter["mission_name"] ,
			"mission_img"	=>	$chapter["mission_img"] ,
			"chapter_id"	=>	$chapter["chapter_id"] ,
			"chapter_name"	=>	$chapter["chapter_name"] ,
			"mission_exp"	=>	$chapter["mission_exp"] ,
			"mission_stamina"	=>	$chapter["mission_stamina"] ,
			);		
	}
$json_row["mission"] = $json;
echo json_encode($json_row); 
	
?>

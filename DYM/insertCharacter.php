<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$macCharacter = 5;
$img = $_GET["img_tu"];
$name_ch = $_GET["name"];

$dataL = mysql_query("SELECT * FROM `character`");
$row = mysql_num_rows($dataL);	

//$row = 15;
$ch_name = $name_ch;
$ch_def = 100;
$ch_atk = 100;
$ch_type = 1;
$ch_rare = 1;
$ch_element = 1;
$ch_img = $img;
$ch_img_mini = "";
$ch_spw = 0;
$ch_sph = 0;
$ch_hp = 100;
$ch_lraderid = $row+1;
$ch_pwxid = $row+1;
$ch_no = $row+1;
$ch_lvmax = 50;


			
			$data = mysql_query("INSERT INTO `character`
			(charac_name,
			charac_def,
			charac_att,
			charac_type,
			charac_rare,
			charac_element,
			charac_img,
			charac_img_mini,
			charac_spw,
			charac_sph,
			charac_hp,
			leader_id,
			pwextra_id,
			charac_no,
			charac_MAXLV)
			VALUES('$ch_name','$ch_def'
				,'$ch_atk'
				,'$ch_type'
				,'$ch_rare'
				,'$ch_element'
				,'$ch_img'
				,'$ch_img_mini'
				,'$ch_spw'
				,'$ch_sph'
				,'$ch_hp'
				,'$ch_lraderid'
				,'$ch_pwxid'
				,'$ch_no'
				,'$ch_lvmax')");


?>
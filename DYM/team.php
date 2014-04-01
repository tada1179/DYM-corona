<?php
include("include/connect.php");

$user_id = $_GET["user_id"];
$team_no = $_GET["team_no"];

$data = mysql_query("SELECT `team`.*,`hold_team`.* 
FROM `team` inner join `hold_team` 
on  `hold_team`.`team_id` = `team`.`team_id`
where `team`.`team_no` = '$team_no' 
and `team`.`user_id` = '$user_id'");

$count = 0;
	while($rowchrdatd=mysql_fetch_row($data)) { 	
		$count = $count + 1;			
		$json_data["character".$count]=$rowchrdatd;
	}  
	
	$json = json_encode($json_data);
	echo $json;
	
?>

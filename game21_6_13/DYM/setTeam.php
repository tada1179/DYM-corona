<?php
include("include/connect.php");

$user_id = $_GET["user_id"];

//$sql = "SELECT * FROM `character` WHERE `charac_id` = 1"; 
$sql = "SELECT * FROM `character`";    //replace with your table name 
$result = mysql_query($sql); 
$json = array(); 
$count=0; 

	if(mysql_num_rows($result)){ 
		while($row=mysql_fetch_row($result)) { 
			$count = $count+1; 
			$json["character".$count]=$row; 
		} 
	} 

echo json_encode($json); 
	
?>

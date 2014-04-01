<?php
include("include/connect.php");

$header = array(7,31,56);

$json1["chrAll"]= 3;
for($i = 0; $i < count($header); $i++){
	$sql = mysql_query("SELECT * FROM `character` WHERE  charac_id = '$header[$i]'");  
	$mydata = mysql_fetch_array($sql);
	$json[] = array(
	"charac_id" => $mydata["charac_id"],
	"charac_img" => $mydata["charac_img_mini"],
	"charac_element" => $mydata["charac_element"],
	"charac_name" => $mydata["charac_name"],
	);
}

$json1["chracter"]=$json;
echo json_encode($json1); 
	
?>

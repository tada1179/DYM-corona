<?php
include("include/connect.php");

$charac_id = $_GET["character"];

$data = mysql_query("SELECT * FROM `character` 
WHERE charac_id = '$charac_id' order by charac_id");
//$mydata = mysql_fetch_array($data);

//$json_data[] = array();
$count = 0;
	while($rowchrdatd=mysql_fetch_row($data)) { 	
		$count = $count + 1;			
		$json_data["character"]=$rowchrdatd;
	}  
	
	$json = json_encode($json_data);
	echo $json;
	
?>

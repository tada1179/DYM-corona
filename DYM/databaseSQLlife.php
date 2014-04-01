<?php 
include("include/connect.php");

$sql = "SELECT * FROM `ticket`";  //replace with your table name 
$result = mysql_query($sql);
$json = array(); 
if(mysql_num_rows($result)){while($row=mysql_fetch_row($result)){ 
$json[]=$row; 
} 
} 
echo json_encode($json); 
?>
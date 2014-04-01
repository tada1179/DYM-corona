<?php
// USER HAVE CHARACTER ALL
$host="localhost";
$user="root";
$pass="";
$db="GAME";
$connect = mysql_connect($host,$user,$pass);
mysql_query("SET NAMES UTF8",$connect); // เอาไว้กรณีให้บังคับตัวหนังสือเป็น UTF 8
mysql_select_db($db);

$user_id = $_GET["user_id"];

$data = mysql_query("SELECT * FROM hold_character 
WHERE user_id = '$user_id' and `hold_character`.`holdcharac_status` ='1' order by charac_id");
$row = mysql_num_rows($data);

//$json_data[] = array();
$json_data = array(  
				"num_row"=>$row
				);
echo $json = json_encode($json_data);
?>

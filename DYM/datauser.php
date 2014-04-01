<?php
include("include/connect.php");

$user_id = $_GET["user_id"];
//$user_id = 1;
$nameTable = "user";

$data = mysql_query("SELECT * FROM user WHERE user_id = '$user_id'");
//$mydata = mysql_fetch_array($data);

$json_data[] = array();
while($mydata = mysql_fetch_array($data)){
   //$json_data = $mydata;
   $json_data = array(  	
        "user_id"=>$mydata['user_id'],  
        "user_name"=>$mydata['user_name'],  
		"user_coin"=>$mydata['user_coin'],
		"user_ticket"=>$mydata['user_ticket'],
		"user_power"=>$mydata['user_power'],
		"user_deck"=>$mydata['user_deck']
    ); 
}
//echo $json_data;
$json = json_encode($json_data);
echo $json;	
?>

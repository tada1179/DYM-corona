<?php
include("include/connect.php");

$data = mysql_query("SELECT * FROM ticket order by ticket_id");
$row = mysql_num_rows($data);

$json_data = array();
$json_data["ticketALL"] = $row;

while($mydata = mysql_fetch_array($data)){
   $json[] = array(  	
        "ticket_id"=>$mydata['ticket_id'],  
        "ticket_amound"=>$mydata['ticket_amound'],  
		"ticket_price"=>$mydata['ticket_price'],
		"ticket_img"=>$mydata['ticket_img']
    ); 
}
$json_data["ticket"]=$json;
echo json_encode($json_data);
	
?>

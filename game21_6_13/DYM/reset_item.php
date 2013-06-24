<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];

$dataup = mysql_query("SELECT 
hold_item.holditem_id,
hold_item.user_id,
hold_item.holditem_amount,use_item.* FROM `hold_item` 
inner join use_item 
on (use_item.holditem_id = hold_item.holditem_id)
where hold_item.user_id = '$myuser_id'");
while($myupdate = mysql_fetch_array($dataup)){
		$insert = mysql_query("DELETE FROM  use_item WHERE useitem_id = '$myupdate[useitem_id]'");
	}


?>

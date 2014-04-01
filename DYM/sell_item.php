<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$itemNumber = $_GET["holditem"];
$numDeleteItem = $_GET["numDeleteItem"]; 


$item = mysql_query("SELECT 
hold_item.holditem_id,
hold_item.user_id,
hold_item.holditem_amount,item.* FROM `hold_item` 
inner join item 
on (item.item_id = hold_item.item_id)
where hold_item.user_id = '$myuser_id'
and hold_item.holditem_id = '$itemNumber'");

while($myitem = mysql_fetch_array($item)){
	$totleamount = $myitem["holditem_amount"] - $numDeleteItem;
	$coinItem = $myitem["item_excoin"] * $numDeleteItem; 
	
	$item_use = mysql_query(" 
		UPDATE  hold_item SET holditem_amount = '$totleamount'
		where holditem_id = '$myitem[holditem_id]'
		");	
	$user = mysql_query("SELECT * FROM user WHERE user_id = '$myuser_id'");	
	$myuser = mysql_fetch_array($user);
	$myCoin = $myuser["user_coin"] + $coinItem;
	
	$CoinUser = mysql_query(" 
		UPDATE  user SET user_coin = '$myCoin'
		where user_id = '$myuser_id'
		");		
		
	}

?>

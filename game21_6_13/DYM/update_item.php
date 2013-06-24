<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
echo "<br />last item:";
echo $chooseitem_id = $_GET["chooseitem_id"];//ตัวเก่า
echo "<br />New item:"; 
echo $newitem_id = $_GET["newitem_id"];//ตัวใหม่



/*$dataup = mysql_query("SELECT 
hold_item.holditem_id,
hold_item.user_id,
hold_item.holditem_amount,use_item.* FROM `hold_item` 
inner join use_item 
on (use_item.holditem_id = hold_item.holditem_id)
where hold_item.user_id = '$myuser_id'
and hold_item.holditem_id = '$chooseitem_id'");
while($myupdate = mysql_fetch_array($dataup)){*/
		$insert = mysql_query("UPDATE use_item SET holditem_id = '$newitem_id' 
		WHERE useitem_id = '$chooseitem_id'");
	//}


?>

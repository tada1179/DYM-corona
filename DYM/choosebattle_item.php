<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$chooseitem_id = $_GET["chooseitem_id"];

$insert = mysql_query("INSERT INTO use_item(holditem_id) values($chooseitem_id)");

?>

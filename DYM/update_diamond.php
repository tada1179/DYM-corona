<?php
//#use team item.lua
include("include/connect.php");

$myuser_id = $_GET["user_id"];
$diamond = $_GET["diamond"];

$hdchr_user =mysql_query("UPDATE `user` SET user_ticket = '$diamond' WHERE user_id = '$myuser_id'");

print("print ok");
?>

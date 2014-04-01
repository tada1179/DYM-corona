<?php
//USE IN SHOW in page discharge  ==> alertmassage.lua
include("include/connect.php");

//$holdcharac_id = $_GET["character"];
$user_id = $_GET["user_id"];
$countCHNo = $_GET["countCHNo"];
$coin = $_GET["coin"];

for($i=1; $i <= $countCHNo; $i++){
	$holdcharac_id = $_GET["character$i"];
	$hdchr_user =mysql_query("SELECT hold_character.* , user. user_id 
	FROM  `hold_character` 
	INNER JOIN  `user` ON hold_character.user_id = user.user_id
	and hold_character.holdcharac_id = '$holdcharac_id'
	where user.user_id = '$user_id'
	");
	
	while($mydata = mysql_fetch_array($hdchr_user)){
		mysql_query("UPDATE  hold_character SET `hold_character`.holdcharac_status = '0' where holdcharac_id = '$mydata[holdcharac_id]'");
		}
}
 
 $update = mysql_query("UPDATE user SET user_coin = '$coin' WHERE user_id = '$user_id'");

$json_row["Coin"] = $coin;
echo json_encode($json_row); 
?>
<?php
//#USER Team_item.lua
//user_id="..user_id.."&LVNext="..characterLEVELUP.LV.."&ExpNext="..ExpforUser.."&HPNext="..HPNext.."&DefNext="..DefNext.."&AtkNext="..AtkNext

include("include/connect.php");
$user_id = $_GET["user_id"];
$LVNext = $_GET["LVNext"];
$ExpNext = $_GET["ExpNext"];
$HPNext = $_GET["HPNext"];
$DefNext = $_GET["DefNext"];
$AtkNext = $_GET["AtkNext"];
$character_id = $_GET["character_id"];
$countCHNo= $_GET["countCHNo"];
$coin = $_GET["coin"];


$hdchr_hdteam = mysql_query("UPDATE hold_character 
SET user_id = '$user_id',holdcharac_lv = '$LVNext',holdcharac_att = '$AtkNext',holdcharac_def = '$DefNext',holdcharac_hp = '$HPNext',holdcharac_exp = '$ExpNext' 
WHERE holdcharac_id = '$character_id' and user_id = '$user_id'");

$usermy = mysql_query("UPDATE user SET user_coin = '$coin' WHERE user_id = '$user_id'");

for($i=1;$i<=$countCHNo ;$i++){
	$ch_id[$i] = $_GET["ch_id$i"];
	$delete = mysql_query("UPDATE hold_character SET `hold_character`.holdcharac_status = '0' WHERE user_id = '$user_id' and holdcharac_id = '$ch_id[$i]'");
	}
$Jcoin["coin"] = $coin;
echo json_encode($Jcoin); 

?>

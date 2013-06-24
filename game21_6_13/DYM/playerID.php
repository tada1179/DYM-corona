<?php
//#USER guest.lua
include("include/connect.php");
//error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
//error_reporting( E_ALL & ~E_NOTICE );
$myuser_id = $_GET["user_id"];
$userfriend_id = $_GET["friend"];
$userleader = 1;
$respone = 1;//respone 1: เป็นเพื่อนกัน
$friend_list = array();

 
$friend = mysql_query("SELECT * FROM user 
WHERE user_id = '$userfriend_id'")or die("ERROR".mysql_error());
$num = mysql_num_rows($friend);

if($myfriend = mysql_fetch_array($friend)){
	$friend_list["friendRow"] = $num;
	
	$friendList = mysql_query("SELECT * FROM friend 
	WHERE user_id = '$myuser_id'
	and friend_userid = '$userfriend_id'and friend_respone='$respone'
	")or die("ERROR".mysql_error());
	$numFriend = mysql_num_rows($friendList);
	// numFriend = 0: ยังไม่ได้เป็นเพื่อนกัน
	// numFriend = 1: เป็นเพื่อนกัน	
	
	$team = mysql_query("SELECT team.* ,hold_team.*
		FROM `team` inner join hold_team
		on hold_team.team_id = team.team_id 
		where team.user_id = '$userfriend_id'
		and hold_team.holdteam_no = '$userleader'
		ORDER BY `team`.`team_lastuse` DESC
	")or die("ERROR2".mysql_error());
		
		if($myteam=mysql_fetch_array($team)){  
			$charac = mysql_query("SELECT `character`.* ,hold_character.*
			FROM `hold_character` inner join `character`
			on hold_character.charac_id = character.charac_id 
			where hold_character.holdcharac_id = '$myteam[holdcharac_id]'
			and hold_character.user_id = '$userfriend_id'
			")or die("ERROR3".mysql_error());
	
			if($mycharac=mysql_fetch_array($charac)){ 
				$friend_json[] = array(
				"friend_respont"=>$numFriend,
				"Friend_id"		=>$userfriend_id,
				"Friend_Lv"		=>$myfriend['user_level'],
				"Friend_name"	=>$myfriend['user_name'],
				"Friend_date"	=>$myteam['team_lastuse'],
				"charac_img"	=>$mycharac['charac_img_mini'],
				"charac_id"		=>$mycharac['holdcharac_id'],
				"charac_element"=>$mycharac['charac_element'],
				"charac_Lv"		=>$mycharac['holdcharac_lv']
				);
			}
		}
		
}else{
	$friend_list["friendRow"] = "NODATA";
}
$friend_list["FRIEND"]=$friend_json;
echo json_encode($friend_list); 
?>
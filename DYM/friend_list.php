<?php
//#USER guest.lua
include("include/connect.php");
$myuser_id = $_GET["user_id"];
$respone = 1 ;
$friend = mysql_query("SELECT friend.friend_id,
friend.friend_userid,
friend.friend_respone,
friend.friend_create,
friend.friend_modify,
user.* 
FROM friend inner join user 
on friend.friend_userid = user.user_id
where friend.user_id = '$myuser_id'
and friend.friend_respone = '$respone'");

$friend_list = array();
$row_fri = mysql_num_rows($friend);
$friend_list["All"]=$row_fri; 

while($myfriend = mysql_fetch_array($friend)){
			$team = mysql_query("SELECT team.* ,hold_team.*
				FROM `team` inner join hold_team
				on hold_team.team_id = team.team_id 
				where team.user_id = '$myfriend[user_id]'
				ORDER BY `team`.`team_lastuse`DESC,holdteam_no ASC
			");	
						
				if($myteam=mysql_fetch_array($team)){  
					$charac = mysql_query("SELECT `character`.* ,hold_character.*
					FROM `hold_character` inner join `character`
					on hold_character.charac_id = character.charac_id 
					where hold_character.holdcharac_id = '$myteam[holdcharac_id]'
					and hold_character.user_id = '$myteam[user_id]'
				");
				
					if($mycharac=mysql_fetch_array($charac)){ 
						$json[]=array( 
						"charac_id"=>$mycharac['charac_id'], 
						 "holdcharac_id"=>$mycharac['holdcharac_id'],
						 "friend_id"=>$myfriend['friend_id'],  
						 "friend_userid"=>$myfriend['friend_userid'],   
						 "friend_name"=>$myfriend['user_name'], 
						 "friend_atk"=>$mycharac['holdcharac_att'],  
						 "friend_def"=>$mycharac['holdcharac_def'],  
						 "friend_hp"=>$mycharac['holdcharac_hp'], 
						 "friend_lv"=>$mycharac['holdcharac_lv'],   
						 "friend_element"=>$mycharac['charac_element'],  
						 "friend_img_mini"=>$mycharac['charac_img_mini'], 
						 "friend_img"=>$mycharac['charac_img'],   
						 "leader_id"=>$mycharac['leader_id'],
						 "friend_modify"=>$myfriend['friend_modify'],
						 "team_lastuse"=>$myteam['team_lastuse'],         
						);
					}	
				}
			//}
	
	}
$friend_list["chracter"]=$json;
echo json_encode($friend_list); 

?>

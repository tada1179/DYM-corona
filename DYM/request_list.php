<?php
//#USER guest.lua
include("include/connect.php");
$myuser_id = $_GET["user_id"];
$respone = 0;

$friend = mysql_query("SELECT friend.friend_id,
friend.friend_userid,
friend.friend_respone,
friend.friend_create,
friend.friend_modify,
user.* 
FROM friend inner join user 
on friend.user_id = user.user_id
where friend.friend_userid = '$myuser_id'
and friend.friend_respone = '$respone'");

$friend_list = array();
$row_fri = mysql_num_rows($friend);
$friend_list["All"]=$row_fri; 

while($myfriend = mysql_fetch_array($friend)){
	//print("Friend id:".$myfriend["friend_userid"]);
			$team = mysql_query("SELECT team.* ,hold_team.*
				FROM `team` inner join hold_team
				on hold_team.team_id = team.team_id 
				where team.user_id = '$myfriend[user_id]'
				ORDER BY `team`.`team_lastuse`,
				hold_team.holdteam_no DESC
			");	
						
				if($myteam=mysql_fetch_array($team)){  
					$charac = mysql_query("SELECT `character`.* ,hold_character.*
					FROM `hold_character` inner join `character`
					on hold_character.charac_id = character.charac_id 
					where hold_character.holdcharac_id = '$myteam[holdcharac_id]'
					and hold_character.user_id = '$myfriend[user_id]'
				");
				
					if($mycharac=mysql_fetch_array($charac)){ 
						$json[]=array(  
						 "charac_id"=>$mycharac['holdcharac_id'], 
						 "friend_id"=>$myfriend['user_id'],
						 "friend_name"=>$myfriend['user_name'],    
						 "friend_lv"=>$myfriend['user_level'], 
						 "charac_atk"=>$mycharac['holdcharac_att'],  
						 "charac_def"=>$mycharac['holdcharac_def'],  
						 "charac_hp"=>$mycharac['holdcharac_hp'], 
						 "charac_lv"=>$mycharac['holdcharac_lv'],   
						 "charac_element"=>$myfriend['user_element'],  
						 "charac_img_mini"=>$mycharac['charac_img_mini'], 
						 "charac_img"=>$mycharac['charac_img'],   
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

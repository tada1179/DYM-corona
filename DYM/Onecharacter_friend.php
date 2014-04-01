<?php
//#USER guest.lua
include("include/connect.php");
$myuser_id = $_GET["user_id"];
$respone = 1 ;
$myfriend_id = $_GET["friend_id"];

$friend = mysql_query("SELECT `friend`.*,
`team`.team_lastuse,
`team`.team_id,
`team`.team_no
FROM `friend` inner join `team` 
on friend.friend_userid = team.user_id
where friend.user_id = '$myuser_id'
and friend.friend_respone = '$respone'
and friend.friend_id = '$myfriend_id'
ORDER BY `team`.`team_lastuse` DESC");

$friend_list = array();
$row_fri = mysql_num_rows($friend);
$friend_list["All"]=$row_fri; 

if($myfriend = mysql_fetch_array($friend)){
	//echo "team_id=".$myfriend["team_id"];
			$team = mysql_query("SELECT * FROM hold_team
				where team_id = '$myfriend[team_id]' 
				and holdteam_no = 1
				ORDER BY  `hold_team`.`holdteam_id` DESC 
			");	
			//echo mysql_num_rows($team);
						
				if($myteam=mysql_fetch_array($team)){  
					$charac = mysql_query("SELECT `character`.* ,hold_character.*
					FROM `hold_character` inner join `character`
					on hold_character.charac_id = character.charac_id 
					where hold_character.holdcharac_id = '$myteam[holdcharac_id]'
					and hold_character.user_id = '$myfriend[friend_userid]' and `hold_character`.holdcharac_status = '1'
				");
				
					if($mycharac=mysql_fetch_array($charac)){ 
						$json[]=array( 
						"charac_id"=>$mycharac['charac_id'], 
						"charac_name"=>$mycharac['charac_name'], 
						 "holdcharac_id"=>$mycharac['holdcharac_id'],
						 "friend_id"=>$myfriend['friend_id'],  
						 "friend_userid"=>$myfriend['friend_userid'],   
						 "friend_atk"=>$mycharac['holdcharac_att'],  
						 "friend_def"=>$mycharac['holdcharac_def'],  
						 "friend_hp"=>$mycharac['holdcharac_hp'], 
						 "friend_lv"=>$mycharac['holdcharac_lv'],   
						 "friend_element"=>$mycharac['charac_element'],  
						 "friend_img_mini"=>$mycharac['charac_img_mini'], 
						 "friend_img"=>$mycharac['charac_img'],   
						 "leader_id"=>$mycharac['leader_id'],
						 "friend_modify"=>$myfriend['friend_modify'],
						 "team_lastuse"=>$myfriend['team_lastuse'],         
						);
					}	
				}
			//}
	
	}
$friend_list["chracter"]=$json;
echo json_encode($friend_list); 

?>

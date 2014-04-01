<?php
//#USER guest.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$respone = 1;//เป็นเพื่อนกันอยู่

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
$rowfriend = 0 ;

while($myfriend = mysql_fetch_array($friend)){
	$chFriend = 1; //รายชื่อจากเพื่อน
	$rowfriend ++;
	
	if($rowfriend<=2){
		$datateam = mysql_query("SELECT team.*,hold_team.* FROM `hold_team` 
			inner join team 
			on(`team`.`team_id` = `hold_team`.`team_id`)
			where `team`.`user_id` = '$myfriend[friend_userid]'
			ORDER BY RAND()LIMIT 1");
			
			if($Mydatateam=mysql_fetch_array($datateam)){
				$characdatd = mysql_query("SELECT hold_character.*,
				character.charac_img_mini,character.charac_element,
				character.charac_img,character.leader_id
				FROM `character` inner join hold_character
				on character.charac_id = hold_character.charac_id 
				where hold_character.holdcharac_id = '$Mydatateam[holdcharac_id]'
				and hold_character.user_id = '$Mydatateam[user_id]' 
				ORDER BY 
				character.leader_id,hold_character.holdcharac_lv,
				`hold_character`.`holdcharac_att`  DESC
				");					
					if($charac=mysql_fetch_array($characdatd)){  
						$json[]=array(  
						"No"=>$rowfriend, 
						 "charac_id"=>$charac['charac_id'], 
						 "friend_userid"=>$dataFriend['friend_userid'], 
						 "friend_id"=>$myfriend['friend_id'],   
						 "friend_name"=>$myfriend['user_name'], 
						 "friend_atk"=>$charac['holdcharac_att'],  
						 "friend_def"=>$charac['holdcharac_def'],  
						 "friend_hp"=>$charac['holdcharac_hp'], 
						 "friend_lv"=>$myfriend['user_level'],   
						 "friend_element"=>$myfriend['user_element'],  
						 "friend_img_mini"=>$charac['charac_img_mini'], 
						 "leader_id"=>$charac['leader_id'],
						 "charac_lv"=>$charac['holdcharac_lv'],
						 "friend_date"=>$Mydatateam['team_lastuse'],
						 "friend_mark"=>$chFriend      
						);	
					}
				}
		
	
	}else{
		$rowfriend = 3;
	}
}
$inity = rand(1,3);
		
$data = "SELECT user.*,`friend`.* FROM `friend` inner join user
on(user.user_id = friend.friend_userid) 
where `friend`.user_id != '$myuser_id' 
and `friend`.friend_userid !='$myuser_id'";
if($inity==3){
	$data."ORDER BY  `friend`.`friend_userid` ASC ";
}else{
	$data."ORDER BY  `friend`.`friend_userid` DESC ";
	}
$Mydata = mysql_query($data);
$rowmyfri = mysql_num_rows($Mydata);
while($dataFriend = mysql_fetch_array($Mydata)){ 
$chFriend = 2; //รายชื่อจากคนอื่นๆที่ไม่ใช่เพื่อน	
	if($rowfriend <= 5){//no myfriend
	
			 $datateam = mysql_query("SELECT team.*,hold_team.* FROM `hold_team` 
				inner join team 
				on(`team`.`team_id` = `hold_team`.`team_id`)
				where `team`.`user_id` = '$dataFriend[friend_userid]'
				ORDER BY `team`.`team_lastuse`");
				
				if($mydatateam = mysql_fetch_array($datateam)){
					$hdFriend = mysql_query("SELECT  `hold_character` . * , 
				 `character`.`charac_img_mini` , 
				  `character`.`charac_element` ,  
				  `character`.`charac_img` ,  
				  `character`.`leader_id` 
					FROM  `character` 
					INNER JOIN  `hold_character` 
					ON  `character`.`charac_id` =  `hold_character`.`charac_id` 
					WHERE  `hold_character`.`user_id` =  '$mydatateam[user_id]'
					ORDER BY RAND()LIMIT 1
				");					
					if($myhdcharacter = mysql_fetch_array($hdFriend)){  
						$json[]=array( 
						"No"=>$rowfriend,  
						 "charac_id"=>$myhdcharacter['charac_id'], 
						 "friend_userid"=>$dataFriend['friend_userid'], 
						 "friend_id"=>$dataFriend['friend_userid'],   
						 "friend_name"=>$dataFriend['user_name'], 
						 "friend_atk"=>$myhdcharacter['holdcharac_att'],  
						 "friend_def"=>$myhdcharacter['holdcharac_def'],  
						 "friend_hp"=>$myhdcharacter['holdcharac_hp'], 
						 "friend_lv"=>$dataFriend['user_level'],   
						 "friend_element"=>$dataFriend['user_element'],  
						 "friend_img_mini"=>$myhdcharacter['charac_img_mini'],   
						 "leader_id"=>$myhdcharacter['leader_id'],
						 "charac_lv"=>$myhdcharacter['holdcharac_lv'],
						 "friend_date"=>$mydatateam['team_lastuse'],
						 "friend_mark"=>$chFriend        
						);	
	
					}
				$rowfriend ++;
				
			}		 
			
		}
}
		
$friend_list["All"]=$rowfriend; 
$friend_list["chracter"]=$json;
echo json_encode($friend_list); 

?>

<?php
//#USER guest.lua
include("include/connect.php");
$user_name = $_GET["user_name"];
$SysdeviceID = $_GET["SysdeviceID"];
$type = $_GET["type"];
date_default_timezone_set('Asia/Bangkok');
$date = date("Y-m-d H:i:s");


$data = mysql_query("INSERT INTO user(user_name,user_udid,user_type,user_exp,user_level,
user_coin,user_element,user_lastlogin,user_deck,user_power)
VALUES('$user_name','$SysdeviceID','$type','0','1','0','$type','$date','30','18')");

$sqlmax = mysql_query("SELECT MAX(user_id) FROM `user`");
$userMax = mysql_fetch_array($sqlmax);
$user_id = $userMax["MAX(user_id)"];

$data = mysql_query("INSERT INTO team(user_id,team_no,team_lastuse)
VALUES('$user_id',1,'$date')");

$a = 0;
$sql = mysql_query("SELECT * FROM `character`");
while($Mysql = mysql_fetch_array($sql)){
	
	//$exp = $Mysql["charac_expmax"]/$Mysql["charac_lvmax"];
	$exp = 0;
	
	if($type == 3 and( $Mysql["charac_id"]==56 or $Mysql["charac_id"]==40 or $Mysql["charac_id"]==12)){//red
	$a++;
		if($Mysql["charac_id"]==12){
			$typedata = mysql_query("INSERT INTO `hold_character` 
			(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
				VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
			'$Mysql[charac_hp]','$exp','1')");
		}
		
		if($Mysql["charac_id"]==40){
			$typedata = mysql_query("INSERT INTO `hold_character` 
			(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
				VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
			'$Mysql[charac_hp]','$exp','1')");
			}	
			
		if($Mysql["charac_id"]==56){
		$typedata = mysql_query("INSERT INTO `hold_character` 
		(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
			VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
		'$Mysql[charac_hp]','$exp','1')");
		}	
			
				$holdchara = mysql_query("SELECT MAX(holdcharac_id) FROM `hold_character`");
				$characMax = mysql_fetch_array($holdchara);
				
				$holdcharac_id = $characMax["MAX(holdcharac_id)"];
				$team = mysql_query("SELECT * FROM `team` WHERE user_id = '$user_id' and team_no = 1");
				$myteam = mysql_fetch_array($team);
				$typedata = mysql_query("INSERT INTO `hold_team` 
				(team_id,holdcharac_id,holdteam_no)
				VALUES('$myteam[team_id]','$holdcharac_id','$a')");	
				
				
		}elseif($type == 1 and( $Mysql["charac_id"]== 7 or $Mysql["charac_id"]==64 or $Mysql["charac_id"]==40)){//green
		$a++;
				if($Mysql["charac_id"]==64){
				$typedata = mysql_query("INSERT INTO `hold_character` 
				(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
					VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
				'$Mysql[charac_hp]','$exp','1')");
				}	
					if($Mysql["charac_id"]==40){
					$typedata = mysql_query("INSERT INTO `hold_character` 
					(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
						VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
					'$Mysql[charac_hp]','$exp','1')");
				}
				
				if($Mysql["charac_id"]==7){
				$typedata = mysql_query("INSERT INTO `hold_character` 
				(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
					VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
				'$Mysql[charac_hp]','$exp','1')");
				}	
				
				$holdchara = mysql_query("SELECT MAX(holdcharac_id) FROM `hold_character`");
				$characMax = mysql_fetch_array($holdchara);
				
				$holdcharac_id = $characMax["MAX(holdcharac_id)"];
				$team = mysql_query("SELECT * FROM `team` WHERE user_id = '$user_id' and team_no = 1");
				$myteam = mysql_fetch_array($team);
				$typedata = mysql_query("INSERT INTO `hold_team` 
				(team_id,holdcharac_id,holdteam_no)
				VALUES('$myteam[team_id]','$holdcharac_id','$a')");	
				
				
			}elseif($type == 2 and( $Mysql["charac_id"]==64 or $Mysql["charac_id"]==12 or $Mysql["charac_id"]==31)){//blue
			$a++;
				if($Mysql["charac_id"]==12){
					$typedata = mysql_query("INSERT INTO `hold_character` 
					(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
						VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
					'$Mysql[charac_hp]','$exp','1')");
				}	
					if($Mysql["charac_id"]==64){
					$typedata = mysql_query("INSERT INTO `hold_character` 
					(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
						VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
					'$Mysql[charac_hp]','$exp','1')");
				}
				
				if($Mysql["charac_id"]==31){
				$typedata = mysql_query("INSERT INTO `hold_character` 
				(user_id,charac_id,holdcharac_lv,holdcharac_att,holdcharac_def,holdcharac_hp,holdcharac_exp,holdcharac_status)
					VALUES('$user_id','$Mysql[charac_id]','$Mysql[charac_lvbase]','$Mysql[charac_att]','$Mysql[charac_def]',
				'$Mysql[charac_hp]','$exp','1')");
				}	
				
				$holdchara = mysql_query("SELECT MAX(holdcharac_id) FROM `hold_character`");
				$characMax = mysql_fetch_array($holdchara);
				
				$holdcharac_id = $characMax["MAX(holdcharac_id)"];
				$team = mysql_query("SELECT * FROM `team` WHERE user_id = '$user_id' and team_no = 1");
				$myteam = mysql_fetch_array($team);
				$typedata = mysql_query("INSERT INTO `hold_team` 
				(team_id,holdcharac_id,holdteam_no)
				VALUES('$myteam[team_id]','$holdcharac_id','$a')");		
	}
	
	
		
}//end while

?>

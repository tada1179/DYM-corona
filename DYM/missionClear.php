<?php
//USE IN SHOW TEAM IN PAGE unit box(inpage team_item)  ==> Character_scene.lua

include("include/connect.php");
$levelMax = 99;
$base_exp =84;

$user_id = $_GET["user_id"];
$team_no = $_GET["team_no"];
$mission_id = $_GET["mission_id"];
$mission_exp = $_GET["mission_exp"];
$chapter_id = $_GET["chapter_id"];
$NumCoin = $_GET["NumCoin"];
$NumFlag = $_GET["NumFlag"];
$diamond = $_GET["diamond"];
$friend = $_GET["friend"];
$jnum = 0;
date_default_timezone_set('Asia/Bangkok');
$dateTime = date("Y-m-d H:i:s");


$sql = mysql_query("SELECT * FROM `user` WHERE user_id = '$user_id'");
$mysql = mysql_fetch_array($sql);

$NumCoin = $mysql["user_coin"] + $NumCoin;
$friend = $mysql["user_FrientPoint"] + $friend;
$mission_exp = $mysql["user_exp"] + $mission_exp;
$user_deck = $mysql["user_deck"] - $NumFlag;
$lever_next = $mysql["user_level"] ;

$user_ticket = $mysql["user_ticket"]+1;
//B + (B * ((L - 1) / M) * (L*1.1)) = E 

$levelExp = 0;
for($i=1;$i<=$levelMax;$i++){
	$levelExp = $levelExp + ($base_exp + ($base_exp* ( ($i-1 )/$levelMax ) * ($i*1.1) ));
	
	if($mission_exp >= $levelExp){
		$lever_next = $i;
	}else{
		$i = $i + $levelMax;
	}
}

$sectionLevel = array(0,10,20,30,40);
for($i=0;$i<=count($sectionLevel);$i++) {
	
	if($lever_next == $sectionLevel[$i]){
		$te = $i+1;
		$inert = mysql_query("INSERT INTO `team`(user_id,team_no,team_lastuse)
		values('$user_id','$te','$dateTime')");
	}
}
if($mysql["user_level"] < $lever_next){//have data update
	$jnum ++;
	$status = "boss";
	$json[] = array(
	"status" => $status,
	);
	
	$section = array(
        18,21,24,27,30,33,37,41,45,50
    );
    $myclass = floor($lever_next/10);
    if (($myclass+1) > 10 ){
        $myclass = 10;
	}else{
        $myclass = $myclass + 1;
	}
	$stamina = $section[$myclass];
	
	$update = mysql_query("UPDATE `user` set user_coin = '$NumCoin'
,user_FrientPoint = '$friend'
,user_exp='$mission_exp'
,user_level = '$lever_next'
,user_power = '$stamina'
where user_id = '$user_id'");

}else{
	$update = mysql_query("UPDATE `user` set user_coin = '$NumCoin'
,user_FrientPoint = '$friend'
,user_exp='$mission_exp'
,user_level = '$lever_next'
 where user_id = '$user_id'");
	}



	for($i=1;$i<=$NumFlag;$i++){
	$id_char = $_GET["getCharac_id$i"];
	
	
	$char = mysql_query("SELECT * FROM `character` WHERE charac_id = '$id_char'");
	$myChar = mysql_fetch_array($char);
	
	mysql_query("INSERT INTO `hold_character`(user_id	,charac_id	,holdcharac_lv,	holdcharac_att,	holdcharac_def,	holdcharac_hp	,holdcharac_exp	,holdcharac_status)
	VALUES('$user_id','$myChar[charac_id]','$myChar[charac_lvbase]','$myChar[charac_att]','$myChar[charac_def]','$myChar[charac_hp]',0,1)");
	}

	$play = mysql_query("SELECT * FROM `user_mission` WHERE user_id = '$user_id' and usermission_id = '$mission_id' and chapter_id = '$chapter_id'");
	$row = mysql_num_rows($play);
	if($row == 0){
		mysql_query("INSERT INTO `user_mission`(user_id,chapter_id,usermission_id)
		VALUES('$user_id','$chapter_id','$mission_id')");	
		
			$chapter = mysql_query("SELECT * FROM `chapter` WHERE chapter_id = '$chapter_id'");
			$MYchapter = mysql_fetch_array($chapter);
			
			$user_mis = mysql_query("SELECT * FROM `user_mission` WHERE user_id = '$user_id' and chapter_id = '$chapter_id'");
			$row_usermis = mysql_num_rows($user_mis);
			
			if($MYchapter["chapter_mission_run"] == $row_usermis){
				$up_pust = mysql_query("UPDATE `user` set user_ticket = '$user_ticket' where user_id = '$user_id'");
			}
		}
	
	
//my use team up exp

$teamCh = mysql_query("SELECT `team`.* ,`hold_team`.* 
	FROM  `team` 
	INNER JOIN `hold_team` 
	ON (`team`.team_id = `hold_team`.team_id)	
	WHERE team.team_no = '$team_no' AND team.user_id = '$user_id'");
	while($myteamCh = mysql_fetch_array($teamCh)){
		$Ch_mission_exp = $mission_exp + $myteamCh["holdcharac_exp"];
		
		$ch_chkarray = mysql_query("SELECT  `character`.* ,
		`hold_character`.holdcharac_id,
		`hold_character`.charac_id,
		`hold_character`.holdcharac_lv,
		`hold_character`.holdcharac_exp
		FROM  `character` 
		INNER JOIN  `hold_character` ON ( `character`.charac_id = `hold_character`.charac_id ) 
		WHERE `hold_character`.holdcharac_id = '$myteamCh[holdcharac_id]' and `hold_character`.user_id = '$user_id'");
		
		$myUse_ch = mysql_fetch_array($ch_chkarray);
		$hold_LVnext = $myUse_ch["holdcharac_lv"];
		
		if($myUse_ch["charac_lvmax"] > $myUse_ch["holdcharac_lv"] or $myUse_ch["holdcharac_exp"] < $myUse_ch["charac_expmax"]){
			if($Ch_mission_exp > $myUse_ch["charac_expmax"]){
					$Ch_mission_exp = $myUse_ch["charac_expmax"];
				}
				
			//{B + [B * ((L - 1) / M) * L]} = E
			$LVcharacter = 0;
			$B = $myUse_ch["charac_expmax"] / $myUse_ch["charac_lvmax"] ;
			$L = $myUse_ch["holdcharac_lv"] ;
			$M = $myUse_ch["charac_lvmax"];
			
			for($j = 1;$j <= $myUse_ch["charac_lvmax"]; $j++){
					$LVcharacter = $LVcharacter + ($B + ($B * ( ($j - 1)/$M ) *$j));
					if($Ch_mission_exp >= $LVcharacter){
						$hold_LVnext = $j;	
						}
				}
				
				if($hold_LVnext < $myUse_ch["charac_lvmax"]){
					$status = NULL;//level up
				}else{
					$status = 99;//level max
				}
				if($myUse_ch["holdcharac_lv"] < $hold_LVnext){//have data update
				$jnum ++;
					$json[] = array(
					"hold_charac_id" => $myUse_ch["holdcharac_id"],
					"charac_img" => $myUse_ch["charac_img_mini"],
					"charac_element" => $myUse_ch["charac_element"],
					"status" => $status,
					);
				}
					
			mysql_query("UPDATE hold_character SET holdcharac_lv = '$hold_LVnext',holdcharac_exp = '$Ch_mission_exp' WHERE holdcharac_id = '$myteamCh[holdcharac_id]'");
					
			}	
	}
$json_row["All"] = $jnum;
$json_row["Levelup"] = $json;
echo json_encode($json_row); 

?>
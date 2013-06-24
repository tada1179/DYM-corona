<?php
include("include/connect.php");

$SysdeviceID = $_GET["deviceID"];

//$sql = "SELECT * FROM `character` WHERE `charac_id` = 1"; 
$sql = "SELECT * FROM `user` WHERE  deviceID = '$SysdeviceID' ORDER BY  `user`.`user_id` DESC";    //replace with your table name 
$result = mysql_query($sql); 
$dataUser = mysql_fetch_array($result);
$myuser_id = $dataUser["user_id"];
//echo "ID:".$myuser_id;

$hdchr_hdteam = mysql_query("SELECT hold_character . * , hold_team . * 
	FROM  `hold_character` 
	INNER JOIN  `hold_team` 
	ON hold_character.holdcharac_id = hold_team.holdcharac_id");

/*$hdchr_chr = "SELECT  character . * ,hold_character . * 
	FROM  `character` 
	INNER JOIN  `hold_character` 
	ON `character`.`charac_id` = `hold_character`.`charac_id`";*/
	
$hdchr_user =mysql_query("SELECT hold_character.charac_id , user. * 
	FROM  `hold_character` 
	INNER JOIN  `user` ON hold_character.user_id = user.user_id
	where user.user_id = '$myuser_id'");
	//echo "<br />have row data:";

	$json = array(); 	
	$numChr = mysql_num_rows($hdchr_user);
	/*$json["chrAll"]=$numChr; 
	$json["chrAll2"]=$numChr+2; */
$i = 0;	
$count=0; 
while($myhdchr_user = mysql_fetch_array($hdchr_user)){
		//echo "<br />character:";
		//echo $myhdchr_user["charac_id"]."<br />";
		
		$chrdatd = mysql_query("SELECT * FROM `character` 
		WHERE charac_id = '$myhdchr_user[charac_id]'");
		
		$count = $count+1;
		 
		/*while($rowchrdatd=mysql_fetch_row($chrdatd)) { 				
			$json["charac".$count]=$rowchrdatd;
		} */
		while($rs=mysql_fetch_array($chrdatd)){  
			$json[]=array(  
        	 "charac_id"=>$rs['charac_id'],  
       		 "charac_img"=>$rs['charac_img'],  
    		);
		}
		
		$i++;
	}

/*	if(mysql_num_rows($result)){ 
		//while($row=mysql_fetch_row($dataUser)) { 
			$count = $count+1; 
			$json["deviceID".$count]=$dataUser; 
		//} 
	} */

echo json_encode($json); 
//$json_array = json_encode($json);

//echo var_export($json_array['charac']);	
?>

<?php
include("include/connect.php");
$SysdeviceID = $_GET["SysdeviceID"];

date_default_timezone_set('Asia/Bangkok');
$dateTime = date("Y-m-d H:i:s");

function timeDiff($firstTime,$lastTime){
   // convert to unix timestamps
   $firstTime=strtotime($firstTime);
   $lastTime=strtotime($lastTime);

   // perform subtraction to get the difference (in seconds) between times
   $timeDiff=$lastTime-$firstTime;

   // return the difference
   return $timeDiff;
}

//Usage :
  



$sql = "SELECT * FROM `user` WHERE  user_udid = '$SysdeviceID' order by user_lastlogin DESC LIMIT 1";    //replace with your table name 
$result = mysql_query($sql); 
$json = array(); 
$count=0; 

	if(mysql_num_rows($result)){ 	
		while($myuser=mysql_fetch_array($result)) { 
				$ch = mysql_query("SELECT * 
				FROM  `hold_character` 
				WHERE user_id = '$myuser[user_id]' and `hold_character`.holdcharac_status = '1'");
				$rowAll = mysql_num_rows($ch);
				
				$coudate = mysql_query("SELECT * 
				FROM  `team` 
				WHERE  `user_id` =  '$myuser[user_id]'
				ORDER BY  `team`.`team_lastuse` DESC 
				LIMIT 1");
				$mydate = mysql_fetch_array($coudate);
				
				$difference = timeDiff($mydate["team_lastuse"],$dateTime);
				$years = abs(floor($difference / 31536000));
				$days = abs(floor(($difference-($years * 31536000))/86400));
				$hours = abs(floor(($difference-($years * 31536000)-($days * 86400))/3600));
				$mins = abs(floor(($difference-($years * 31536000)-($days * 86400)-($hours * 3600))/60));#floor($difference / 60);
				//echo "<p>Time Passed: " . $years . " Years, " . $days . " Days, " . $hours . " Hours, " . $mins . " Minutes.</p>";
				
				
				$section = array(
					18,21,24,27,30,33,37,41,45,50
				);
				$class = $myuser["user_level"]/10;
				if (($class) > 10 )
					$class = 10;
				else{
					$class = $class ;
				}
				
				$staminafull = $section[$class];
				
				$user_power = 0;
				if($years == 0)
					if($days == 0)
						if($hours == 0)
							if($mins == 0)
								$point = $mins/5;
							else{
								$point = $mins/5;	
							}
						else{
							$point = ($hours*60)/5;
						}
					else{
						$point = 0;
						$user_power = $staminafull;
					}
				else{
					$point = 0;
					$user_power = $staminafull;	
				}						
				
				if($user_power == $staminafull){
					 $user_power = $staminafull;
					 
					}else{
						 $time = $staminafull - $myuser["user_power"];
									
						if($time < $point){
							$user_power = $staminafull ;
							
						}else{
							$user_power = $point+ $myuser["user_power"];
						}
					}
				
			$count = $count+1; 
			$json["deviceID".$count]= array(
			"user_id"=>$myuser["user_id"],
			"user_name"=>$myuser["user_name"], 
			"user_type"=>$myuser["user_type"], 
			"user_coin"=>$myuser["user_coin"],
			"user_ticket"=>$myuser["user_ticket"], 
			"user_power"=>$user_power, 
			"user_deck"=>$myuser["user_deck"],
			"user_exp"=>$myuser["user_exp"],
			"user_level"=>$myuser["user_level"],
			"user_FrientPoint"=>$myuser["user_FrientPoint"],
			"user_characterAll"=>$rowAll           
			);
		} 
		
		/*while($row=mysql_fetch_row($result)) { 
			$count = $count+1; 
			$json["deviceID".$count]=$row; 
		} */
	} 

echo json_encode($json); 
	
?>

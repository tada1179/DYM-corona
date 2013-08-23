<?php
	require "config/conn.php";
	
	
	
	$id =$_GET[id];
	$state =$_GET[state];
	$team =$_GET[team];
	
	$arrID=array();
	
	$show=mysql_query("SELECT * FROM team ");
	while ($rowShow=mysql_fetch_array($show)){
		$arrID[]=$rowShow["ddd"];
	}
	
//	$data=array('id'=>$id,'state'=>$state);

	echo json_encode(array("id"=>$id));
	
	/*SELECT *,b.holdcharac_id FROM `team`as a
LEFT JOIN hold_team as b ON a.team_id = b.team_id
LEFT JOIN hold_character as c ON b.holdcharac_id = c.charac_id
WHERE a.team_main ='1' and c.user_id ='1'
*/
?>
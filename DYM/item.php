<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];

$item = mysql_query("SELECT 
hold_item.holditem_id,
hold_item.user_id,
hold_item.holditem_amount,item.* FROM `hold_item` 
inner join item 
on (item.item_id = hold_item.item_id)
where hold_item.user_id = '$myuser_id'");
$count = 0;
$allItem = 0;
while($myitem = mysql_fetch_array($item)){
	$allItem = $allItem + $myitem["holditem_amount"];
	$json1["AllItem"]=$allItem;
	
	$item_use = mysql_query(" 
		SELECT * from use_item
		where holditem_id = '$myitem[holditem_id]'
		");
		
		$numItem = mysql_num_rows($item_use);
		$count = $count + $numItem;
		//echo "<br />numItem:".$numItem;
		$json1["All"]=$count ; 
		if($numItem){
			//$json1["All"]=$numItem; 
			while($myitem_use = mysql_fetch_array($item_use)){
				//echo "<br />while:".$myitem['holditem_id'];
					$json[]=array(  
					 //"holdcharac_id"=>$myhdchr_user['holdcharac_id'],  
					 "useitem_id"=>$myitem_use['useitem_id'],
					 "holditem_id"=>$myitem['holditem_id'],
					 "item_name"=>$myitem['item_name'] ,  
					 "item_id"	=>$myitem['item_id'],  
					 "element"	=>$myitem['item_element'],  
					 "img"		=>$myitem['item_img'], 
					 "img_mini"	=>$myitem['item_img_mini'],   
					 "excoin"	=>$myitem['item_excoin'],  
					 "ticket"	=>$myitem['item_ticket']    
					);
			}
		}		
	
	}
$json1["chracter"]=$json;
echo json_encode($json1); 

?>

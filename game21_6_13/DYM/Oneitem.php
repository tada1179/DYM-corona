<?php
//#USER item_setting.lua


include("include/connect.php");
$myuser_id = $_GET["user_id"];
$item_id = $_GET["item_id"];


$item = mysql_query("SELECT 
hold_item.holditem_id,
hold_item.user_id,
hold_item.holditem_amount,item.* FROM `hold_item` 
inner join item 
on (item.item_id = hold_item.item_id)
where hold_item.user_id = '$myuser_id'");

	$json1 = array(); 	
	$numChr = 0;
	
	$count = 0;
while($myitem = mysql_fetch_array($item)){
	$item_use = mysql_query(" 
		SELECT * from use_item
		where holditem_id = '$myitem[holditem_id]'
		");
		
		$numItem = mysql_num_rows($item_use);
		//$count = $count + $numItem;
		if($numItem){
			while($myitem_use = mysql_fetch_array($item_use)){
				$amount = $myitem["holditem_amount"] - $numItem;
			}
		}else{
			
			$amount = $myitem["holditem_amount"] ;
			}
			
		
		if($amount){
			$numChr = $numChr + 1;	
				$json[]=array(  
			 //"holdcharac_id"=>$myhdchr_user['holdcharac_id'],  
			 "useitem_id"=>$myitem_use['useitem_id'],
			 "holditem_id"=>$myitem['holditem_id'],
			 "item_name"=>$myitem['item_name'] ,  
			 "holditem_amount"=>$amount, 
			 "item_id"	=>$myitem['item_id'],  
			 "element"	=>$myitem['item_element'],  
			 "img"		=>$myitem['item_img'], 
			 "img_mini"	=>$myitem['item_img_mini'],   
			 "excoin"	=>$myitem['item_excoin'],  
			 "ticket"	=>$myitem['item_ticket']    
			);	
		}
		$json1["All"]=$numChr; 	
			
	
	}
$json1["chracter"]=$json;
echo json_encode($json1); 

?>

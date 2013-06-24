<?php
//#USER guest.lua
include("include/connect.php");
echo $user_id = $_GET["user_id"];
echo $userfriend_id = $_GET["friend"];
echo $respont = $_GET["respont"];
 
echo $datetime = date("Y-m-d H:i:s");

//respont = 0 : ขอเป็นเพื่อน
//respont = 1 : รับเป็นเพื่อน
//respont = 2 : ยกเลิกเป็นเพื่อน/ไม่รับเป็นเพื่อน
if($respont == 0){
	$data2 = mysql_query("SELECT * FROM friend 
		WHERE user_id = '$user_id'
		and friend_userid = '$userfriend_id' 
		");
		if($rowdata2 = mysql_num_rows($data2)){
			//echo json_encode(  "UPDATE22");
			$myfriend2 = mysql_query("UPDATE friend 
			SET friend_respone = '$respont',
			friend_modify = '$datetime'
			WHERE friend_userid = '$userfriend_id'
			and user_id = '$user_id'");
			
			
			
		}else{
			//echo json_encode( "insert33");
			$myfriend2 = mysql_query("INSERT INTO friend(user_id,
			friend_userid,friend_respone,
			friend_create,friend_modify) 
			VALUES('$user_id','$userfriend_id','$respont','$datetime','$datetime')");
			
		}		
	}
else{
		$data = mysql_query("SELECT * FROM friend 
		WHERE user_id = '$userfriend_id '
		and friend_userid = '$user_id' 
		");
		if($rowdata = mysql_num_rows($data)){
			//echo json_encode(  "UPDATE");
			$myfriend = mysql_query("UPDATE friend 
			SET friend_respone = '$respont',
			friend_modify = '$datetime'
			WHERE friend_userid = '$user_id'
			and user_id = '$userfriend_id'");
			
			$data2 = mysql_query("SELECT * FROM friend 
				WHERE user_id = '$user_id'
				and friend_userid = '$userfriend_id' 
				");
				if($rowdata2 = mysql_num_rows($data2)){
					//echo json_encode(  "UPDATE22");
					$myfriend2 = mysql_query("UPDATE friend 
					SET friend_respone = '$respont',
					friend_modify = '$datetime'
					WHERE friend_userid = '$userfriend_id'
					and user_id = '$user_id'");
					
					
					
				}else{
					//echo json_encode( "insert33");
					$myfriend2 = mysql_query("INSERT INTO friend(user_id,
					friend_userid,friend_respone,
					friend_create,friend_modify) 
					VALUES('$user_id','$userfriend_id','$respont','$datetime','$datetime')");
					
				}	
		
		}else{
			//echo json_encode( "insert");
			$myfriend = mysql_query("INSERT INTO friend(user_id,
			friend_userid,friend_respone,
			friend_create,friend_modify) 
			VALUES('$userfriend_id','$user_id','$respont','$datetime','$datetime')");
		}
	}




?>
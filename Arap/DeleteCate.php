<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-874">
<title>เพิ่มหมวดคำศัพท์</title>
<?php require_once('connect.php'); 
$get_id = $_GET["Cate_id"];
$data = mysql_query("SELECT `category`.* ,`vocabulary`.* FROM `category` inner join `vocabulary` on(`vocabulary`.Cate_id = `category`.Cate_id) where `vocabulary`.Cate_id = '$get_id'");

if($numRow = mysql_num_rows($data)){
	?>
	<script language="javascript">
    alert("มีการเรียกใช้งานอยู่ไม่สามารถลบได้");
		window.location.href = "AddCate.php";
    </script>
	<?
}else{
	$data = mysql_query("DELETE FROM category
		WHERE Cate_id='$get_id';");
		?>
	<script language="javascript">
    alert("ลบข้อมูลเรียบร้อยแล้ว");
	window.location.href = "AddCate.php";
    </script>
	<?
}
?>

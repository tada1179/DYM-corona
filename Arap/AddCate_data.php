<?php require_once('connect.php'); 
//initialize the session
if (!isset($_SESSION)) {
  session_start();
}
if($_POST['Cate_name']!=""){
	if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
	  $insertSQL = mysql_query("INSERT INTO category (Cate_name) VALUES '$_POST[Cate_name]'")or die(mysql_error());		
		  $insertGoTo = "AddCate.php";
		  header(sprintf("Location: %s", $insertGoTo));
	}
}else{?>
	<script language="javascript">
		alert("insert type name !");
		window.location.href = "AddCate.php";
	</script>
		
<? }
?>


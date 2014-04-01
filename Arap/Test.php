<?php require_once('Connections/connect.php'); ?>
<?php
if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

mysql_select_db($database_connect, $connect);
$query_Show = "SELECT * FROM category";
$Show = mysql_query($query_Show, $connect) or die(mysql_error());
$row_Show = mysql_fetch_assoc($Show);
$totalRows_Show = mysql_num_rows($Show);

$colname_Recordset11 = "-1";
if (isset($_POST['Search'])) {
  $colname_Recordset11 = $_POST['Search'];
}
mysql_select_db($database_connect, $connect);
$query_Recordset11 = sprintf("SELECT * FROM category WHERE Cate_name LIKE %s", GetSQLValueString("%" . $colname_Recordset11 . "%", "text"));
$Recordset11 = mysql_query($query_Recordset11, $connect) or die(mysql_error());
$row_Recordset11 = mysql_fetch_assoc($Recordset11);
$totalRows_Recordset11 = mysql_num_rows($Recordset11);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<form id="form1" name="form1" method="post" action="Test.php">
ค้นหา :
  <input type="text" name="Search" id="Search" />
  <input type="submit" name="btnsearch" id="btnsearch" value="Submit" />
</form>
<p></p>
<table border="1">
  <tr>
    <td>Cate_id</td>
    <td>Cate_name</td>
  </tr>
  <?php do { ?>
    <tr>
      <td><?php echo $row_Recordset11['Cate_id']; ?></td>
      <td><?php echo $row_Recordset11['Cate_name']; ?></td>
    </tr>
    <?php } while ($row_Recordset11 = mysql_fetch_assoc($Recordset11)); ?>
</table>
</body>
</html>
<?php
mysql_free_result($Show);

mysql_free_result($Recordset11);
?>

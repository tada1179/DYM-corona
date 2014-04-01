<?php require_once('connect.php'); ?>
<?php
//initialize the session
if (!isset($_SESSION)) {
  session_start();
}

// ** Logout the current user. **
$logoutAction = $_SERVER['PHP_SELF']."?doLogout=true";
if ((isset($_SERVER['QUERY_STRING'])) && ($_SERVER['QUERY_STRING'] != "")){
  $logoutAction .="&". htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_GET['doLogout'])) &&($_GET['doLogout']=="true")){
  //to fully log out a visitor we need to clear the session varialbles
  $_SESSION['MM_Username'] = NULL;
  $_SESSION['MM_UserGroup'] = NULL;
  $_SESSION['PrevUrl'] = NULL;
  unset($_SESSION['MM_Username']);
  unset($_SESSION['MM_UserGroup']);
  unset($_SESSION['PrevUrl']);
	
  $logoutGoTo = "AdminLogin.php";
  if ($logoutGoTo) {
    header("Location: $logoutGoTo");
    exit;
  }
}
?>
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

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
  $updateSQL = sprintf("UPDATE category SET Cate_name=%s WHERE Cate_id=%s",
                       GetSQLValueString($_POST['Cate_name'], "text"),
                       GetSQLValueString($_POST['Cate_id'], "int"));

  mysql_select_db($database_connect, $connect);
  $Result1 = mysql_query($updateSQL, $connect) or die(mysql_error());

  $updateGoTo = "AddCate.php";
  if (isset($_SERVER['QUERY_STRING'])) {
    $updateGoTo .= (strpos($updateGoTo, '?')) ? "&" : "?";
    $updateGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $updateGoTo));
}

$colname_Recordset1 = "-1";
if (isset($_GET['Cate_id'])) {
  $colname_Recordset1 = $_GET['Cate_id'];
}
mysql_select_db($database_connect, $connect);
$query_Recordset1 = sprintf("SELECT * FROM category WHERE Cate_id = %s", GetSQLValueString($colname_Recordset1, "int"));
$Recordset1 = mysql_query($query_Recordset1, $connect) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>แก้ไขข้อมูลหมวดคำศัพท์</title>
<style type="text/css">
body,td,th {
	font-size: 16px;
}
</style>
</head>

<body bgcolor="#3b5998">
<div align="center">
  <table width="1024" height="255" border="1">
    <tr>
      <td height="255"><img src="button/banner011.jpg" width="1024" height="255" /></td>
    </tr>
    <tr>
      <td height="1" bgcolor="#F0F8FF"><table width="1024" border="1">
          <tr valign="top">
            <td width="281"><table width="200">
              
              <tr>
                <td><a href="Index.php"><img src="button/ButtonHome11.jpg" width="280" height="65" /></a></td>
              </tr>
              
              <tr>
                <td><img src="button/ButtonCate1.jpg" width="280" height="65" /></td>
              </tr>
              
              <tr>
                <td><a href="AddDeal.php"><img src="button/ButtonDeal.jpg" width="280" height="65" /></a></td>
              </tr>
             
              
              <tr>
                <td><a href="<?php echo $logoutAction ?>"><img src="button/Buttonlogin1.jpg" width="280" height="65" /></a></td>
              </tr>
              
            </table></td>
            
            <td width="727" a align="center">
            <p><strong>
            <h3>แก้ไขข้อมูลหมวดคำศัพท์
            </h3></strong>
            <form action="<?php echo $editFormAction; ?>" method="post" name="form1" id="form1">
              <table width="363" height="151" align="center">
                <tr valign="baseline">
                  <td width="149" height="48" align="left" nowrap="nowrap">รหัส</td>
                  <td width="202"><?php echo $row_Recordset1['Cate_id']; ?></td>
                </tr>
                <tr valign="baseline">
                  <td height="53" align="left" nowrap="nowrap">ชื่อหมวดคำศัพท์</td>
                  <td><input type="text" name="Cate_name" value="<?php echo htmlentities($row_Recordset1['Cate_name'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
                </tr>
                <tr valign="baseline">
                  <td nowrap="nowrap" align="right">&nbsp;</td>
                  <td><input type="submit" value="แก้ไข" /></td>
                </tr>
              </table>
              <input type="hidden" name="MM_update" value="form1" />
              <input type="hidden" name="Cate_id" value="<?php echo $row_Recordset1['Cate_id']; ?>" />
          </form>
          <p>&nbsp;</p>            </tr>
        </table>
    </table>
</div>
</body>
</html>
<?php
mysql_free_result($Recordset1);
?>

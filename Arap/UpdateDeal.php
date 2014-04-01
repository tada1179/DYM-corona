<?php require_once('connect.php'); ?>
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
  $updateSQL = sprintf("UPDATE vocabulary SET Thai_Vocab=%s, Arab_Vocab=%s, Pronounce=%s, Sound=%s, Cate_id=%s WHERE Vocab_id=%s",
                       GetSQLValueString($_POST['Thai_Vocab'], "text"),
                       GetSQLValueString($_POST['Arab_Vocab'], "text"),
                       GetSQLValueString($_POST['Pronounce'], "text"),
                       GetSQLValueString($_POST['Sound'], "text"),
                       GetSQLValueString($_POST['Cate_id'], "int"),
                       GetSQLValueString($_POST['Vocab_id'], "int"));

  mysql_select_db($database_connect, $connect);
  $Result1 = mysql_query($updateSQL, $connect) or die(mysql_error());

  $updateGoTo = "AddDeal.php";
  if (isset($_SERVER['QUERY_STRING'])) {
    $updateGoTo .= (strpos($updateGoTo, '?')) ? "&" : "?";
    $updateGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $updateGoTo));
}

$colname_Recordset2 = "-1";
if (isset($_GET['Vocab_id'])) {
  $colname_Recordset2 = $_GET['Vocab_id'];
}
mysql_select_db($database_connect, $connect);
$query_Recordset2 = sprintf("SELECT * FROM vocabulary WHERE Vocab_id = %s", GetSQLValueString($colname_Recordset2, "int"));
$Recordset2 = mysql_query($query_Recordset2, $connect) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);
$totalRows_Recordset2 = mysql_num_rows($Recordset2);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>แก้ไขข้อมูลคำศัพท์</title>
</head>

<body>

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
                <td><a href="AddCate.php"><img src="button/ButtonCate.jpg" width="280" height="65" /></a></td>
              </tr>
              
              <tr>
                <td><img src="button/ButtonDeal1.jpg" width="280" height="65" /></td>
              </tr>
             
              
              <tr>
                <td><a href="<?php echo $logoutAction ?>"><img src="button/Buttonlogin1.jpg" width="280" height="65" /></a></td>
              </tr>
              
            </table></td>
            
            <td width="727" a align="center">
            <p><strong>
            <h3>แก้ไขข้อมูลคำศัพท์
            </h3></strong>
<form action="<?php echo $editFormAction; ?>" method="post" name="form1" id="form1">
  <table height="242" align="center">
    <tr valign="baseline">
      <td width="168" align="left" nowrap="nowrap">รหัส</td>
      <td width="232"><?php echo $row_Recordset2['Vocab_id']; ?></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="left"><span class="style9">คำศัพท์ภาษาไทย</span></td>
      <td><input type="text" name="Thai_Vocab" value="<?php echo htmlentities($row_Recordset2['Thai_Vocab'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="left"><span class="style9">คำศัพท์ภาษาอาหรับ</span></td>
      <td><input type="text" name="Arab_Vocab" value="<?php echo htmlentities($row_Recordset2['Arab_Vocab'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="left">คำอ่านคำศัพท์ภาษาอาหรับ</td>
      <td><input type="text" name="Pronounce" value="<?php echo htmlentities($row_Recordset2['Pronounce'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="left">ไฟล์เสียง</td>
      <td><input type="file" name="Sound" value="<?php echo htmlentities($row_Recordset2['Sound'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
    </tr>
    <tr valign="baseline">
      <td nowrap="nowrap" align="right">&nbsp;</td>
      <td><input type="submit" value="แก้ไข" /></td>
    </tr>
  </table>
  <input type="hidden" name="MM_update" value="form1" />
  <input type="hidden" name="Vocab_id" value="<?php echo $row_Recordset2['Vocab_id']; ?>" />
</form>
<p>&nbsp;</p>            </tr>
        </table>
    </table>
</div>
</body>
</html>

<?php
mysql_free_result($Recordset2);
?>

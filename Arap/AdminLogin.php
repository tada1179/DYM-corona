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
?>
<?php
// *** Validate request to login to this site.
if (!isset($_SESSION)) {
  session_start();
}

$loginFormAction = $_SERVER['PHP_SELF'];
if (isset($_GET['accesscheck'])) {
  $_SESSION['PrevUrl'] = $_GET['accesscheck'];
}

if (isset($_POST['Uneme'])) {
  $loginUsername=$_POST['Uneme'];
  $password=$_POST['Pword'];
  $MM_fldUserAuthorization = "";
  $MM_redirectLoginSuccess = "IndexDeal.php";
  $MM_redirectLoginFailed = "AdminLogin.php";
  $MM_redirecttoReferrer = false;
  mysql_select_db($database_connect, $connect);
  
  $LoginRS__query=sprintf("SELECT Username, Password FROM `admin` WHERE Username=%s AND Password=%s",
    GetSQLValueString($loginUsername, "text"), GetSQLValueString($password, "text")); 
   
  $LoginRS = mysql_query($LoginRS__query, $connect) or die(mysql_error());
  $loginFoundUser = mysql_num_rows($LoginRS);
  if ($loginFoundUser) {
     $loginStrGroup = "";
    
	if (PHP_VERSION >= 5.1) {session_regenerate_id(true);} else {session_regenerate_id();}
    //declare two session variables and assign them
    $_SESSION['MM_Username'] = $loginUsername;
    $_SESSION['MM_UserGroup'] = $loginStrGroup;	      

    if (isset($_SESSION['PrevUrl']) && false) {
      $MM_redirectLoginSuccess = $_SESSION['PrevUrl'];	
    }
    header("Location: " . $MM_redirectLoginSuccess );
  }
  else {
	  ?>
	  <script language="javascript">
      alert('user name or password wrongful');
      </script>
	  <?
 //   header("Location: ". $MM_redirectLoginFailed );
  }
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login เข้าสู่ระบบ</title>
<style type="text/css">
body,td,th {
	font-size: 16px;
}
</style>
</head>

<body bgcolor="#3b5998">
<div align="center">
  <table width="1024" height="255" border="1">
<tr valign="top">
      <td height="255"><img src="button/banner011.jpg" width="1024" height="255" /></td>
    </tr>
    <tr>
      <td height="1" bgcolor="#F0F8FF"><table width="1024" border="1">
          <tr  valign="top">
            <td width="281"><table width="200" height="209">
              <tr valign="top">
                <td><a href="Index.php"><img src="button/ButtonHome1.jpg" width="280" height="65" /></a></td>
              </tr>
             
              <tr valign="top">
                <td><a href="SearchVocab.php"><img src="button/ButtonSearch1.jpg" width="280" height="65" /></a></td>
              </tr>
              
              <tr valign="top">
                <td ><img src="button/ButtonAdmin.jpg" width="280" height="65" /></td>
              </tr>
              
            </table></td>
            
            
            <td width="727" align="center"><p><span class="style4"><img src="button/55.png" width="101" height="92" align="middle" /></span>
              
              </p>
              <p><span class="style4"><font color="#FF0000">กรุณาป้อน Username และ Password</font></span></p>
              </p>
              <form ACTION="<?php echo $loginFormAction; ?>" id="form1" name="form1" method="POST">
                <p>Username
  <input type="text" name="Uneme" id="Uneme" />
                  <br />
                  <br />
                  Password
                  <input type="password" name="Pword" id="Pword" />
                  <br />
                  <br />
                  <input type="submit" name="btnLogin" id="btnLogin" value="ตรวจสอบ" />
                </p>
                
              </form>
              <p>&nbsp;</p>
            </tr>
            
    </table>
</body>
</html>

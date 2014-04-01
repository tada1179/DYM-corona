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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>หน้าหลักของการจัดการข้อมูลคำศัพท์</title>
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
                <td><a href="AddCate.php"><img src="button/ButtonCate.jpg" width="280" height="65" /></a></td>
              </tr>
              
              <tr>
                <td><a href="AddDeal.php"><img src="button/ButtonDeal.jpg" width="280" height="65" /></a></td>
              </tr>
             
              
              <tr>
                <td><a href="<?php echo $logoutAction ?>"><img src="button/Buttonlogin1.jpg" width="280" height="65" /></a></td>
              </tr>
            </table></td>
            
            <td width="727" align="center">
            <p><strong>
            <h2>จัดการข้อมูล</h2></strong></p>
            <p><img src="button/6.jpg" width="157" height="179" /></p>
            </td>
          </tr>
        </table>
    </table>
</div>
</body>
</html>

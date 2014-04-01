 <? ob_start() ?> 
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

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form2")) {
  $insertSQL = sprintf("INSERT INTO vocabulary (Thai_Vocab, Arab_Vocab, Pronounce, Sound ,Cate_id) VALUES (%s, %s, %s, %s, %s)",
                       GetSQLValueString($_POST['Thai_Vocab'], "text"),
                       GetSQLValueString($_POST['Arab_Vocab'], "text"),
                       GetSQLValueString($_POST['Pronounce'], "text"),
                       GetSQLValueString($_POST['Sound'], "text"),
					   GetSQLValueString($_POST['listCate'], "text"));

  mysql_select_db($database_connect, $connect);
  $Result1 = mysql_query($insertSQL, $connect) or die(mysql_error());

  $insertGoTo = "AddDeal.php";
  if (isset($_SERVER['QUERY_STRING'])) {
    $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
    $insertGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $insertGoTo));
}
// จอย table Category,Vocabulary
//mysql_select_db($database_connect, $connect);
//$query_VocabularySet ="SELECT * FROM Category INNER JOIN Vocabulary 
//ON Category.Cate_id = Vocabulary.Vocab_id";

mysql_select_db($database_connect, $connect);
$query_VocabularySet = "SELECT * FROM vocabulary";
$VocabularySet = mysql_query($query_VocabularySet, $connect) or die(mysql_error());
$row_VocabularySet = mysql_fetch_assoc($VocabularySet);
$totalRows_VocabularySet = mysql_num_rows($VocabularySet);

mysql_select_db($database_connect, $connect);
$strSQL = "SELECT * FROM vocabulary";
$objQuery = mysql_query($strSQL, $connect) or die(mysql_error());
$Num_Rows = mysql_num_rows($objQuery);
 
			

$Per_Page = 10;   // Per Page

$Page = $_GET["Page"];
if(!$_GET["Page"])
{
	$Page=1;
}

$Prev_Page = $Page-1;
$Next_Page = $Page+1;

$Page_Start = (($Per_Page*$Page)-$Per_Page);
if($Num_Rows<=$Per_Page)
{
	$Num_Pages =1;
}
else if(($Num_Rows % $Per_Page)==0)
{
	$Num_Pages =($Num_Rows/$Per_Page) ;
}
else
{
	$Num_Pages =($Num_Rows/$Per_Page)+1;
	$Num_Pages = (int)$Num_Pages;
}

$strSQL .=" order  by Vocab_id ASC LIMIT $Page_Start , $Per_Page";
$objQuery  = mysql_query($strSQL);

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>เพิ่มข้อมูลคำศัพท์</title>
<style type="text/css">
body,td,th {
	font-size: 16px;
}
</style>

</head>
<script language="javascript">
function fncSubmit()
{
	if(document.register.listCate.value == 0)//กรุณากรอกรหัสนักเรียน
	{
		alert('Insert list category please');
		document.register.listCate.focus();
		return false;
	}
	
	if(document.register.Thai_Vocab.value == "")//กรุณากรอกรหัสนักเรียน
	{
		alert('Insert Thai Vocab please');
		document.register.Thai_Vocab.focus();
		return false;
	}
	
	if(document.register.Arab_Vocab.value == "")//กรุณากรอกรหัสนักเรียน
	{
		alert('Insert Arab Vocab please');
		document.register.Arab_Vocab.focus();
		return false;
	}
	if(document.register.Pronounce.value == "")//กรุณากรอกรหัสนักเรียน
	{
		alert('Insert Pronounce please');
		document.register.Pronounce.focus();
		return false;
	}
	
	if(document.register.Sound.value == "")//กรุณากรอกรหัสนักเรียน
	{
		alert('Insert Sound please');
		document.register.Sound.focus();
		return false;
	}
}
</script>
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
            <p>            
            <h2><strong>จัดการข้อมูลคำศัพท์
            </strong></h2>
            <p></p>
            <form action="<?php echo $editFormAction; ?>" method="post" name="register" id="register" onSubmit="JavaScript:return fncSubmit();">
              <table width="470" height="178" align="center">
                <tr valign="baseline">
                  <td height="32" align="left" nowrap="nowrap">เลือกหมวดคำศัพท์</td>
                  <td><? 
				  $data = mysql_query("SELECT * FROM category WHERE status = 0");				
				  ?>
                    <select name="listCate" id="listCate">
                      <option value="0" selected="selected">เลือก</option>
                      <?   while($mydata = mysql_fetch_array($data)){?>
                      <option value="<? echo $mydata["Cate_id"]; ?>"><? echo $mydata["Cate_name"];?></option>
                      <? } ?>
                    </select></td>
                </tr>
                <tr valign="baseline">
                  <td height="32" align="left" nowrap="nowrap"><span class="style9">คำศัพท์ภาษาไทย</span></td>
                  <td><input type="text" name="Thai_Vocab" value="" size="32" /></td>
                </tr>
                <tr valign="baseline">
                  <td height="27" align="left" nowrap="nowrap"><span class="style9">คำศัพท์ภาษาอาหรับ</span></td>
                  <td><input type="text" name="Arab_Vocab" value="" size="32" /></td>
                </tr>
                <tr valign="baseline">
                  <td height="30" align="left" nowrap="nowrap">คำอ่านคำศัพท์ภาษาอาหรับ</td>
                  <td><input type="text" name="Pronounce" value="" size="32" /></td>
                </tr>
                <tr valign="baseline">
                  <td height="30" align="left" nowrap="nowrap">ไฟล์เสียง</td>
                  <td><input type="file" name="Sound" id="Sound" size="32"/></td>
                </tr>
                <tr valign="baseline">
                  <td nowrap="nowrap" align="right">&nbsp;</td>
                  <td><input type="submit" value="เพิ่ม" /></td>
                </tr>
              </table>
              <input type="hidden" name="MM_insert" value="form2" />
            </form>
            <table width="832" border="1" align="center">
          <tr align="center">
                <td width="40">รหัส</td>
                <td width="130">คำศัพท์ภาษาไทย</td>
                <td width="150">คำศัพท์ภาษาอาหรับ</td>
                <td width="160">หมวดหมู่</td>
            <td width="160">คำอ่าน</td>
                  <td width="40">ไฟล์เสียง</td>
                  <td colspan="2" width="15">เพิ่มเติม</td>
          </tr>
          <?php while($row_ShowData = mysql_fetch_array($objQuery)){ 
		  $value = mysql_query("SELECT * FROM category WHERE Cate_id = '$row_ShowData[Cate_id]'");	
$datavalue = mysql_fetch_array($value); 
		  ?>
                <tr>
                  <td align="center"><?php echo $row_ShowData['Vocab_id']; ?></td>
                  <td align="center"><?php echo $row_ShowData['Thai_Vocab']; ?></td>
                  <td align="center"><?php echo $row_ShowData['Arab_Vocab']; ?></td>
                  <td align="center"><?php echo $datavalue['Cate_name']; ?></td>
                  <td><?php echo $row_ShowData['Pronounce']; ?></td>
                  <td><?php echo $row_ShowData['Sound']; ?></td>
                  <td width="50" align="center"><a href="UpdateDeal.php?Vocab_id=<?php echo $row_ShowData['Vocab_id']; ?>">แก้ไข</a></td>
                  <td width="50" align="center"><a href="DeleteDeal.php?Vocab_id=<?php echo $row_ShowData['Vocab_id']; ?>">ลบ</a></td>
                </tr>
                <?php } ?>
        </table></p>
           <br>
Total <?= $Num_Rows;?> Record : <?=$Num_Pages;?> Page :
<?
if($Prev_Page)
{
	echo " <a href='$_SERVER[SCRIPT_NAME]?Page=$Prev_Page'><< Back</a> ";
}

for($i=1; $i<=$Num_Pages; $i++){
	if($i != $Page)
	{
		echo "[ <a href='$_SERVER[SCRIPT_NAME]?Page=$i'>$i</a> ]";
	}
	else
	{
		echo "<b> $i </b>";
	}
}
if($Page!=$Num_Pages)
{
	echo " <a href ='$_SERVER[SCRIPT_NAME]?Page=$Next_Page'>Next>></a> ";
}
?>
          </table>
        </table>
 

</div>
</body>
</html>
<?php
mysql_free_result($VocabularySet);

 ob_end_flush()  
?>

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

$colname_Recordset1 = "-1";
if (isset($_POST['Cate_name'])) {
  $colname_Recordset1 = $_POST['Cate_name'];
}
mysql_select_db($database_connect, $connect);
$query_Recordset1 = sprintf("SELECT * FROM category WHERE Cate_name = %s", GetSQLValueString($colname_Recordset1, "text"));
$Recordset1 = mysql_query($query_Recordset1, $connect) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

$colname_Recordset2 = "-1";
if (isset($_POST['SearchT-A'])) {
  $colname_Recordset2 = $_POST['SearchT-A'];
}
mysql_select_db($database_connect, $connect);
$query_Recordset2 = sprintf("SELECT * FROM vocabulary WHERE Thai_Vocab LIKE %s", GetSQLValueString("%" . $colname_Recordset2 . "%", "text"));
$Recordset2 = mysql_query($query_Recordset2, $connect) or die(mysql_error());
$row_Recordset2 = mysql_fetch_assoc($Recordset2);
$totalRows_Recordset2 = mysql_num_rows($Recordset2);
if($totalRows_Recordset2==0 and isset($_POST["listCate"])){?>
<script type="text/javascript">
alert("ไม่มีข้อมูล");
</script>
<?php }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ค้นหาคำศัพท์ไทย-อาหรับ</title>
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
                <td><a href="Index.php"><img src="button/ButtonHome1.jpg" width="280" height="65" /></a></td>
              </tr>
              <tr>
                <td><img src="button/ButtonT-A1.jpg" width="280" height="65" /></td>
              </tr>
              <tr>
                <td><a href="SearchVocabA-T.php"><img src="button/ButtonA-T.jpg" width="280" height="65" /></a></td>
              </tr>
            </table></td>
            
            <td width="727" align="center">
            <p><strong>ค้นหาคำศัพท์จากภาษาไทย-อาหรับ</strong></p>
            <form id="form2" name="form2" method="post" action="SearchVocabT-A.php">
              <table width="410" height="80">
               
                <tr>
                <td width="143">เลือกหมวดคำศัพท์
                  </td>
                <td width="168"><p>
                  <select name="listCate" id="listCate">
                  <option value="01">ทั้งหมด</option>
                  <option value="02">วันต่าง ๆ ในสัปดาห์</option>
                  <option value="03">เดือน</option>
                  <option value="04">ฤดูกาล</option>
                  <option value="05">ช่วงเวลา</option>
                  <option value="06">ครอบครัว</option>
                  <option value="07">อวัยวะต่าง ๆ ของร่างกาย</option>
                  <option value="08">ผัก</option>
                  <option value="09">ผลไม้</option>
                  <option value="10">ประเทศและเมืองหลวง</option>
                </select>
                </p></td>
              </tr>
              
              
              
              <tr>
                <td>คำศัพท์ที่ต้องการค้นหา
                  </td>
                <td><input type="text" name="SearchT-A" id="SearchT-A" />
                  <input type="submit" name="Show" id="Search" value="ค้นหา" /></td>
              </tr>
              
          </table>
              </p>
            </form>
           
            <table border="1">
              <tr align="center">
                <td>คำศัพท์ภาษาไทย</td>
                <td>คำศัพท์ภาษาอาหรับ</td>
                <td>คำอ่านคำศัพท์ภาษาอาหรับ</td>
                <td>เสียง</td>
                </tr>
              <?php do { ?>
                <tr>
                  <td><?php echo $row_Recordset2['Thai_Vocab']; ?></td>
                  <td><?php echo $row_Recordset2['Arab_Vocab']; ?></td>
                  <td><?php echo $row_Recordset2['Pronounce']; ?></td>
                  <td align="center"><img src="button/audio1.jpg" width="24" height="25" /></td>
                </tr>
                <?php } while ($row_Recordset2 = mysql_fetch_assoc($Recordset2)); ?>
          </table>
            <p>&nbsp;</p></td>
          </tr>
        </table>
        
    </table>
</div>
</body>
</html>
<?php
mysql_free_result($Recordset1);

mysql_free_result($Recordset2);
?>

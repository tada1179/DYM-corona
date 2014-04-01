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

$colname_ShowCate = "-1";
if (isset($_POST['SearchA-T'])) {
  $colname_ShowCate = $_POST['SearchA-T'];
}

mysql_select_db($database_connect, $connect);
$query_ShowCate = sprintf("SELECT * FROM vocabulary WHERE Arab_Vocab LIKE %s", GetSQLValueString("%" . $colname_ShowCate . "%", "text"));
$ShowCate = mysql_query($query_ShowCate, $connect) or die(mysql_error());
$row_ShowCate = mysql_fetch_assoc($ShowCate);
$totalRows_ShowCate = mysql_num_rows($ShowCate);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ค้นหาคำศัพท์อาหรับ-ไทย</title>
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
      <td height="255"><img src="ปุ่ม/banner011.jpg" width="1024" height="255" /></td>
    </tr>
    <tr>
      <td height="1" bgcolor="#F0F8FF"><table width="1024" border="1">
          <tr valign="top">
            <td width="281"><table width="200">
              <tr>
                <td><a href="Index.php"><img src="ปุ่ม/ButtonHome1.jpg" width="280" height="65" /></a></td>
              </tr>
              <tr>
                <td><a href="SearchVocabT-A.php"><img src="ปุ่ม/ButtonT-A.jpg" width="280" height="65" border="0" /></a></td>
              </tr>
              <tr>
                <td><img src="ปุ่ม/ButtonA-T1.jpg" width="280" height="65" /></td>
              </tr>
            </table>
            </td>
            <td width="727" align="center">
            <p><strong>ค้นหาคำศัพท์จากภาษาอาหรับ-ไทย</strong></p>
            <form id="form1" name="form1" method="post" action="SearchVocabA-T.php">
              <table width="410" height="80">
                <tr>
                <td><span class="style9">เลือกหมวดคำศัพท์</span></td>
                <td><select name="listCate" id="listCate">
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
                </select></td>
              </tr>
              <tr>
                <td><span class="style9">คำศัพท์ที่ต้องการค้นหา</span></td>
                <td><input type="text" name="SearchA-T" id="SearchA-T" />                  <input type="submit" name="Search" id="Search" value="ค้นหา" /></td>
              </tr>
          </table>
              </p>
            </form>
            <table border="1">
              <tr align="center">
                <td>คำศัพท์ภาษาอาหรับ</td
                ><td>คำศัพท์ภาษาไทย</td>
                <td>คำอ่านคำศัพท์ภาษาอาหรับ</td>
                <td>เสียง</td>
                </tr>
              <?php do { ?>
                <tr>
                  <td><?php echo $row_ShowCate['Arab_Vocab']; ?></td>
                  <td><?php echo $row_ShowCate['Thai_Vocab']; ?></td>
                  <td><?php echo $row_ShowCate['Pronounce']; ?></td>
                  <td align="center"><img src="ปุ่ม/audio1.jpg" width="24" height="25" /></td>
                  </tr>
                <?php } while ($row_ShowCate = mysql_fetch_assoc($ShowCate)); ?>
          </table>
            <p>&nbsp;</p></td>
          </tr>
        </table>
  </table>
</div>
</body>
</html>
<?php
mysql_free_result($ShowCate);
?>

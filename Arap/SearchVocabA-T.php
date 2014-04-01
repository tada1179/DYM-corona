<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" name="robots" />
<style type="text/css">

/* 

 -------------------------------------------------------------

 In-page demo CSS - see external CSS for actual relevant stuff.

 --------------------------------------------------------------

 */

#soundmanager-debug {
 /* SM2 debug container (optional, makes debug more useable) */
 position:absolute;position:fixed;*position:absolute;bottom:10px;right:10px;width:50em;height:18em;overflow:auto;background:#fff;margin:1em;padding:1em;border:1px solid #999;font-family:"lucida console",verdana,tahoma,"sans serif";font-size:x-small;line-height:1.5em;opacity:0.9;filter:alpha(opacity=90);
}

body {
 font:75% normal verdana,arial,tahoma,"sans serif";
}

h1, h2, h3 {
 font:2.5em arial,tahoma,verdana;
 font-weight:normal;
 margin-bottom:0px;
}

h1, h2 {
 letter-spacing:-1px; /* zomg web x.0! ;) */ 
 margin-top:0.5em;
}

h2, h3 {
 color:#333;
}

h2 {
 font-size:2em;
}

h3 {
 font-size:1.5em;
}

h1 a,
h1 a:hover {
 color:#000;
 text-decoration:none;
}

h1 a:hover {
 text-decoration:underline;
}

ul li {
 margin-bottom:0.5em;
}

ul.notes {
 margin-left:0px;
 padding-left:1.5em;
}

.note {
 margin-top:0px;
 font-style:italic;
 color:#666;
}

pre {
 font-weight:bold;
 font-size:1.2em;
 _font-size:1em;
}

pre code {
 color:#228822;
}

#left {
 max-width:56em;
}

</style>
<link rel="stylesheet" type="text/css" href="css/mp3-player-button.css" />
<!-- soundManager.useFlashBlock: related CSS -->
<link rel="stylesheet" type="text/css" href="flashblock/flashblock.css" />
<script type="text/javascript" src="script/soundmanager2.js"></script>
<script type="text/javascript" src="script/mp3-player-button.js"></script>
<script>
soundManager.setup({
  useFlashBlock: true, // optional - if used, required flashblock.css
  url: 'swf/' // required: path to directory containing SM2 SWF files
});
</script>

</head>



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

$colname_ShowCate = "-1";
if (isset($_POST['SearchA-T'])) {
  $colname_ShowCate = $_POST['SearchA-T'];
}

mysql_select_db($database_connect, $connect);
if (isset($_POST['SearchA-T']) or $_GET["Page"]!="" ){
	if($_POST['SearchA-T']!="" and $_POST["listCate"]!=0){
		$query_ShowCate = sprintf("SELECT * FROM vocabulary WHERE Arab_Vocab LIKE %s or Thai_Vocab LIKE %s and Cate_id LIKE %s",
GetSQLValueString("%" . $colname_ShowCate . "%", "text"),
GetSQLValueString("%" . $colname_ShowCate . "%", "text"),
GetSQLValueString("%" . $_POST["listCate"] . "%", "text"));

	}elseif($_POST['SearchA-T']=="" and $_POST['listCate']==0){
		$query_ShowCate = "SELECT * FROM vocabulary";
		
	}elseif($_POST['listCate']!=0){
		$query_ShowCate = "SELECT * FROM vocabulary WHERE Cate_id = '$_POST[listCate]'";
	
	}elseif($_POST['SearchA-T']){
		$query_ShowCate = sprintf("SELECT * FROM vocabulary WHERE Arab_Vocab LIKE %s or Thai_Vocab LIKE %s",
GetSQLValueString("%" . $colname_ShowCate . "%", "text"),
GetSQLValueString("%" . $colname_ShowCate . "%", "text"));
	}elseif($_GET["query_ShowCate"]){
		$query_ShowCate = $_GET["query_ShowCate"];
	}
		
$ShowCate = mysql_query($query_ShowCate, $connect) or die(mysql_error());
$row_ShowCate = mysql_fetch_assoc($ShowCate);
$Num_Rows = mysql_num_rows($ShowCate);

$Per_Page = 10;   // Per Page

$Page = $_GET["Page"];
$i = (($Page -1) * 10)+1;
if(!$_GET["Page"] or $Page == 1)
{
	$Page=1;
	$i = 1;
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

$query_ShowCate .=" order  by Vocab_id ASC LIMIT $Page_Start , $Per_Page";
$ShowCate  = mysql_query($query_ShowCate);




if($Num_Rows==0 and isset($_POST["listCate"])){?>
<script type="text/javascript">
alert("ไม่มีข้อมูล ");
</script>
<?php }
}
?>		



<body>
<div id="center">
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
                <td><a href="SearchVocabT-A.php"><img src="button/ButtonT-A.jpg" width="280" height="65" border="0" /></a></td>
              </tr>
              <tr>
                <td><img src="button/ButtonA-T1.jpg" width="280" height="65" /></td>
              </tr>
            </table>
            </td>
            <td width="727" align="center">
            <p><strong>ค้นหาคำศัพท์จากภาษาอาหรับ-ไทย</strong></p>
            <form id="form1" name="form1" method="post" action="SearchVocabA-T.php">
              <table width="410" height="80">
                <tr>
                <td><span class="style9">เลือกหมวดคำศัพท์</span></td>
                <td>
                  <? 
				  $data = mysql_query("SELECT * FROM category WHERE status = 0");				
				  ?>
                    <select name="listCate" id="listCate">
                      <option value="0" selected="selected">แสดงทั้งหมด</option>
                      <?   while($mydata = mysql_fetch_array($data)){?>
                      <option value="<? echo $mydata["Cate_id"]; ?>"><? echo $mydata["Cate_name"];?></option>
                      <? } ?>
                    </select></td>
              </tr>
              <tr>
                <td><span class="style9">คำศัพท์ที่ต้องการค้นหา</span></td>
                <td><input type="text" name="SearchA-T" id="SearchA-T" />                  <input type="submit" name="Search" id="Search" value="ค้นหา" /></td>
              </tr>
          </table>
              </p>
            </form>
            <?php if ($Num_Rows != 0) { ?>
            <table width="539" border="1">
              <tr align="center">
                <td width="39">ลำดับ</td
                >
                <td width="144">คำศัพท์ภาษาอาหรับ</td
                ><td width="132">คำศัพท์ภาษาไทย</td>
                <td width="141">คำอ่านคำศัพท์ภาษาอาหรับ</td>
                <td width="32">เสียง</td>
                </tr>
              <?php 
			  
			  while ($row_ShowCate = mysql_fetch_assoc($ShowCate)){?>
                <tr>
                  <td align="center"><? echo $i++;?></td>
                  <td><?php echo $row_ShowCate['Arab_Vocab']; ?></td>
                  <td><?php echo $row_ShowCate['Thai_Vocab']; ?></td>
                  <td><?php echo $row_ShowCate['Pronounce']; ?></td>
                  <td>
                  <div id="center">
                  <p> 
                    <a href="sound/<?php echo $row_ShowCate['Sound']; ?>.mp3" title="Play &quot;Office Lobby&quot;" class="sm2_button">Office Lobby</a>
                  </p>
                  </div></td>              </tr>
                <?php }  ?>
          </table>
               
		
		        <br>
ทั้งหมด <?= $Num_Rows;?> Record : <?=$Num_Pages;?> หน้า :
<?
if($Prev_Page)
{
	echo " <a href='$_SERVER[SCRIPT_NAME]?Page=$Prev_Page&query_ShowCate=$query_ShowCate'><< Back</a> ";
}

for($i=1; $i<=$Num_Pages; $i++){
	if($i != $Page)
	{
		echo "[ <a href='$_SERVER[SCRIPT_NAME]?Page=$i&query_ShowCate=$query_ShowCate'>$i</a> ]";
	}
	else
	{
		echo "<b> $i </b>";
	}
}
if($Page!=$Num_Pages)
{
	echo " <a href ='$_SERVER[SCRIPT_NAME]?Page=$Next_Page&query_ShowCate=$query_ShowCate'>Next>></a> ";
} } ?>
            </td>
          </tr>
        </table>

  </table>
</div>
</body>
</html>
<?php
//mysql_free_result($ShowCate);
?>

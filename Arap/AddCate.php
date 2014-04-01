<?php $hostname_connect = "localhost";
$database_connect = "db532021402";
$username_connect = "root";
$password_connect = "";

$connect = mysql_pconnect($hostname_connect, $username_connect, $password_connect) or trigger_error(mysql_error(),E_USER_ERROR); 
mysql_query("set NAMES tis620");
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=windows-874">
<title>เพิ่มหมวดคำศัพท์</title>
<style type="text/css">
body,td,th {
	font-size: 16px;
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
</style>
<script language="javascript">
	function delete(){
		var answer=confirm('Do you Really want to do this?')
		if (answer) {
			alert("1 ");
			alert();
		}else{
			alert("1222");
		}
	
	}
</script>
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
                <td><a href="index.php"><img src="button/Buttonlogin1.jpg" width="280" height="65" /></a></td>
              </tr>    
            </table></td>
            
            <td width="727" a align="center">
            <p><strong>
            <h2>จัดการข้อมูลหมวดคำศัพท์
            </h2></strong>
            <form action="AddCate_data.php" method="post" name="form1" id="form1" onSubmit="JavaScript:return fncSubmit();" >
              <table width="423" height="44" align="center">
                <tr valign="baseline">
                  <td width="130" height="39" align="left" nowrap="nowrap">เพิ่มหมวดคำศัพท์</td>
                  <td width="313"><input type="text" name="Cate_name" value="" size="32" />
                    <input type="submit" value="เพิ่ม" /></td>
                </tr>
                
             
              </table>
              <p>
                <input type="hidden" name="MM_insert" value="form1" />
                
              </p>
              </p>
            </form>
            <table width="426" border="1">
        <tr align="center">
          <td width="50">รหัส</td>
          <td width="197">ชื่อหมวดคำศัพท์</td>
          <td colspan="2">เพิ่มเติม</td>
          </tr>
        <?php  
		$ShowCategory = mysql_query( "SELECT * FROM category") or die(mysql_error());
$totalRows_ShowCategory = mysql_num_rows($ShowCategory);

		while ($row_CategorySet = mysql_fetch_array($ShowCategory)) { ?>
          <tr>
            <td><?php echo $row_CategorySet['Cate_id']; ?></td>
            <td><?php echo $row_CategorySet['Cate_name']; ?></td>
            <td width="36" align="center"><a href="UpdateCate.php?Cate_id=<?php echo $row_CategorySet['Cate_id']; ?>">แก้ไข</a></td>
            <td width="22" align="center"><a href="javascript:void(0);" onclick="theVar=confirm('คุณต้องการที่จะลบหรือไม่?');setTimeout('if(theVar){window.location=\'http://localhost/arap/DeleteCate.php?Cate_id=<?php echo $row_CategorySet['Cate_id'];?>\'}', 0);">ลบ</a></td>
          </tr>
          <?php } //<a href="DeleteCate.php?Cate_id= <?php echo $row_CategorySet['Cate_id']; " onclick="delete();">?>
      </table></p></td>
          </tr>
        </table>
  </table>
</div>
</body>
</html>


<script src="SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
<table width="503" border="1">
  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr>
    <td width="148">ID</td>
    <td width="339"><form id="form3" name="form3" method="post" action="">
      <span id="sprytextfield3">
        <label for="user_id"></label>
        <input type="text" name="user_id" id="user_id" />
        <span class="textfieldRequiredMsg">A value is required.</span></span>
    </form></td>
  </tr>
  <tr>
    <td>File image</td>
    <td><form id="form1" name="form1" method="post" action="">
      <span id="sprytextfield1">
        <label for="image"></label>
        <input type="file" name="image" id="image" />
        <span class="textfieldRequiredMsg">A value is required.</span></span>
    </form></td>
  </tr>
</table>
<script type="text/javascript">
var sprytextfield1 = new Spry.Widget.ValidationTextField("sprytextfield1");
var sprytextfield3 = new Spry.Widget.ValidationTextField("sprytextfield3");
</script>
<?php
$host="localhost";
$user="root";
$pass="";
$db="DYM";
$connect = mysql_connect($host,$user,$pass);
mysql_query("SET NAMES UTF8",$connect); // เอาไว้กรณีให้บังคับตัวหนังสือเป็น UTF 8
mysql_select_db($db);

$username = $_GET["name"];
$id = $_GET["id"];

/*$username = "tada1179@";
$id = 1234;*/

$data = mysql_query("INSERT INTO user ( user_id,user_name ) values('$id','$username')")
or die("mysql_error:".mysql_error());	
/*$qr = mysql_query("SELECT * FROM user")or die("ERROR select user:".mysql_error());
/*$mydata = mysql_fetch_array($data);
echo "id:".$mydata["user_id"]."  name:".$mydata["user_name"];

$q="SELECT * FROM province_th WHERE 1 ORDER BY province_id";  
$qr=mysql_query($q); 
*/ 
/*while($rs=mysql_fetch_array($qr)){  
    $json_data[]=array(  
        "id"=>$rs['user_id'],  
        "name"=>$rs['user_name'],  
    );    
} 
 
$json= json_encode($json_data);  
echo $json; */
	
?>

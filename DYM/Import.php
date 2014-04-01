<html>
<head>
<title>ThaiCreate.Com PHP(COM) Excel.Application Tutorial</title>
</head>
<body>
<?
	//*** Get Document Path ***//
	$strPath = realpath(basename(getenv($_SERVER["SCRIPT_NAME"]))); // C:/AppServ/www/myphp
	$OpenFile = "gametable.xls";
	//*** Create Exce.Application ***//
	$xlApp = new COM("Excel.Application");
	$xlBook = $xlApp->Workbooks->Open($strPath."/".$OpenFile);
	//$xlBook = $xlApp->Workbooks->Open(realpath($OpenFile));

	$xlSheet1 = $xlBook->Worksheets(1);	

	//*** Insert to MySQL Database ***//
	/*$objConnect = mysql_connect("localhost","root","root") or die("Error Connect to Database");
	$objDB = mysql_select_db("mydatabase");*/
include("include/connect.php");

	for($i=1;$i<=136;$i++){
		If(trim($xlSheet1->Cells->Item($i,1)) != "")
		{
			$strSQL = "";
			$strSQL .= "INSERT INTO customer2 ";
			$strSQL .= "(CustomerID,Name,Email,CountryCode,Budget,Used) ";
			$strSQL .= "VALUES ";
			$strSQL .= "('".$xlSheet1->Cells->Item($i,1)."','".$xlSheet1->Cells->Item($i,2)."' ";
			$strSQL .= ",'".$xlSheet1->Cells->Item($i,3)."','".$xlSheet1->Cells->Item($i,4)."' ";
			$strSQL .= ",'".$xlSheet1->Cells->Item($i,5)."','".$xlSheet1->Cells->Item($i,6)."') ";
			mysql_query($strSQL);
		}
	}
	
	//*** Close MySQL ***//
	@mysql_close($objConnect);

	//*** Close & Quit ***//
	$xlApp->Application->Quit();
	$xlApp = null;
	$xlBook = null;
	$xlSheet1 = null;
?>
Data Import/Inserted.
</body>
</html>

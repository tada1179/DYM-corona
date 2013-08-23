<?php
	define("DB_DSN",'puzzle');
	define("DB_HOST",'seo.bulks.jp');
	define("DB_USER",'admin');
	define("DB_PASS",'XZQZW8RE');
	/* 
	// Connecting, selecting database

	//mysql_connect(DB_HOST,DB_USER,DB_PASS) or die('Could not connect: ' . mysql_error());
	//mysql_select_db(DB_DSN) or die("Could not select database");
	*/	
	mysql_connect(DB_HOST,DB_USER,DB_PASS) or die('Could not connect: ' . mysql_error());
	mysql_select_db(DB_DSN) or die("Could not select database");
	
?>

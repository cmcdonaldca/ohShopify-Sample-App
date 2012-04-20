<?php
	/* SHOPIFY CONFIG */
	define('API_KEY', '');
	define('SECRET', '');
	
	if (class_exists("Smarty"))
	{
		$smarty = new Smarty;
		//$smarty->force_compile = true;
		$smarty->debugging = false;
		$smarty->caching = false;
		$smarty->cache_lifetime = 120;
	}


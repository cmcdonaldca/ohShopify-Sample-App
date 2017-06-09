<?php
	/* SHOPIFY CONFIG */
	define('SHOPIFY_API_KEY', 'f85f47c3576a07ddce8020f1d627256c');
	define('SHOPIFY_SECRET', 'f3ab246eba53494a2eb1d6d22063d1a1');
	define('SHOPIFY_SCOPE', 'write_content,write_products,write_orders');
	
	if (class_exists("Smarty"))
	{
		$smarty = new Smarty;
		//$smarty->force_compile = true;
		$smarty->debugging = false;
		$smarty->caching = false;
		$smarty->cache_lifetime = 120;
	}

	/* simple debug function */
	function debug(&$var) {
		echo "<pre>";
		print_r($var);
		echo "</pre>";
	}

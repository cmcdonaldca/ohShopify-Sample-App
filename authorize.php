<?php
include_once('lib/Smarty-3.1.4/libs/Smarty.class.php');
include_once('lib/config.lib.php');
include_once('lib/session.lib.php');
include_once('lib/ohShopify/shopify.php');

// if the code param has been sent to this page... we are in Step 2
if (isset($_GET['code'])) {

	// Step 2: do a form POST to get the access token
	$shopifyClient = new ShopifyClient($_GET['shop'], "", SHOPIFY_API_KEY, SHOPIFY_SECRET);
	session_unset();
	$_SESSION['token'] = $shopifyClient->getAccessToken($_GET['code']);
	if ($_SESSION['token'] != '')
		$_SESSION['shop'] = $_GET['shop'];

	header("Location: index.php");
	exit;
} else if (isset($_POST['shop']) || isset($_GET['shop'])) {
	
	// Step 1: get the shopname from the user and redirect the user to the
	// shopify authorization page where they can choose to authorize this app
	$shop = isset($_POST['shop']) ? $_POST['shop'] : $_GET['shop'];
	$shopifyClient = new ShopifyClient($shop, "", SHOPIFY_API_KEY, SHOPIFY_SECRET);

	// get the URL to the current page
	$pageURL = 'http';
	if ($_SERVER["HTTPS"] == "on") { $pageURL .= "s"; }
	$pageURL .= "://";
	if ($_SERVER["SERVER_PORT"] != "80") {
		$pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
	} else {
		$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
	}

	// redirect to authorize url
	header("Location: " . $shopifyClient->getAuthorizeUrl(SHOPIFY_SCOPE, $pageURL));
	exit;
}

// Show the form to ask the user for their shop name
$smarty->display('templates/header.tpl');
$smarty->display('templates/authorize.tpl');
$smarty->display('templates/footer.tpl');

?>

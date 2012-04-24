<?php
	try {
		$shop_response = $shopifyClient->call('GET', '/admin/shop.json');
		$smarty->assign('shop_name', $shop_response['name']);
		$product_count_response = $shopifyClient->call('GET', '/admin/products/count.json');
		$smarty->assign('product_count', $product_count_response);
	} catch (ShopifyApiException $ex) {
		// handle the exception
		debug($ex);
	}

?>

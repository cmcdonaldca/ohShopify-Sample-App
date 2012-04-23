<?php
	try {
		$shop_response = $shopifyClient->call('GET', '/admin/shop.json');
		$smarty->assign('shop_name', $shop_response['shop']['name']);
		$product_count_response = $shopifyClient->call('GET', '/admin/products/count.json');
		$smarty->assign('product_count', $product_count_response['count']);
	} catch (ShopifyApiException $ex) {
		// handle the exception
	}

?>

package lib.terraform.CB_TFAZR_055

test_aks_api_server_auth_up_ranges_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"pike",
		],
		"Attributes": {"private_cluster_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aks_api_server_auth_up_ranges_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"pike",
		],
		"Attributes": {"private_cluster_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

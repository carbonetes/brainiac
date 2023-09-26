package lib.terraform.CB_TFAZR_054

test_rbac_enabled_on_aks {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"pike",
		],
		"Attributes": {"role_based_access_control_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rbac_not_enabled_on_aks {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"pike",
		],
		"Attributes": {"role_based_access_control_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

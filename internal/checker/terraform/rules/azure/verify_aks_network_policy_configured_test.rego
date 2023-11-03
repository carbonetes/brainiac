package lib.terraform.CB_TFAZR_056

test_aks_network_policy_configured {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "network_profile",
			"Labels": [],
			"Attributes": {"network_policy": "azure"},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_aks_network_policy_not_configured {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "network_profile",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

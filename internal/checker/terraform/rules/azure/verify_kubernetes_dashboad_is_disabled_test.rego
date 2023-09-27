package lib.terraform.CB_TFAZR_059

test_kubernetes_dashboard_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "addon_profile",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "kube_dashboard",
				"Labels": [],
				"Attributes": {"enabled": false},
				"Blocks": [],
				"line_range": {
					"endLine": 5,
					"startLine": 3,
				},
			}],
			"line_range": {
				"endLine": 6,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_dashboard_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_kubernetes_cluster",
			"test",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "addon_profile",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "kube_dashboard",
				"Labels": [],
				"Attributes": {"enabled": true},
				"Blocks": [],
				"line_range": {
					"endLine": 5,
					"startLine": 3,
				},
			}],
			"line_range": {
				"endLine": 6,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

package lib.terraform.CB_TFNCP_023

test_ncloud_lb_listener_utilizing_https_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_listener",
			"example",
		],
		"Attributes": {
			"load_balancer_id": "ncloud_lb.example.id",
			"port": "443",
			"protocol": "HTTPS",
			"tls_min_version": "TLSv1.2",
			"tls_min_version_type": "TLSV12",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_lb_listener_utilizing_https_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_listener",
			"example",
		],
		"Attributes": {
			"load_balancer_id": "ncloud_lb.example.id",
			"port": "443",
			"protocol": "",
			"tls_min_version": "TLSv1.2",
			"tls_min_version_type": "TLSV12",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

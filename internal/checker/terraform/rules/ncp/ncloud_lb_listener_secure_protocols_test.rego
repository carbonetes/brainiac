package lib.terraform.CB_TFNCP_013

test_ncloud_lb_listener_secure_protocols_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_listener",
			"example",
		],
		"Attributes": {
			"default_associate_acl": "ncloud_access_control_group.example.id",
			"load_balancer_id": "ncloud_load_balancer.example.id",
			"name": "example-listener",
			"protocol": "HTTPS",
			"ssl_policy_id": "ncloud_ssl_policy.example.id",
			"tls_min_version_type": "TLSV12",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_lb_listener_secure_protocols_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb_listener",
			"example",
		],
		"Attributes": {
			"default_associate_acl": "ncloud_access_control_group.example.id",
			"load_balancer_id": "ncloud_load_balancer.example.id",
			"name": "example-listener",
			"protocol": "HTTPS",
			"ssl_policy_id": "ncloud_ssl_policy.example.id",
			"tls_min_version_type": "",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

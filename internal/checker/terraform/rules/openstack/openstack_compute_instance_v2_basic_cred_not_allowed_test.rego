package lib.terraform.CB_TFOPENSTACK_004

test_openstack_compute_instance_v2_basic_cred_not_allowed_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_compute_instance_v2",
			"fail",
		],
		"Attributes": {
			"admin_pass": "",
			"flavor_id": "3",
			"image_id": "ad091b52-742f-469e-8f3c-fd81cadf0743",
			"name": "basic",
			"security_groups": ["default"],
			"user_data": "#cloud-config\nhostname: instance_1.example.com\nfqdn: instance_1.example.com",
		},
		"Blocks": [{
			"Type": "network",
			"Labels": [],
			"Attributes": {"name": "my_network"},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 9,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_openstack_compute_instance_v2_basic_cred_not_allowed_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_compute_instance_v2",
			"fail",
		],
		"Attributes": {
			"admin_pass": "N0tSoS3cretP4ssw0rd",
			"flavor_id": "3",
			"image_id": "ad091b52-742f-469e-8f3c-fd81cadf0743",
			"name": "basic",
			"security_groups": ["default"],
			"user_data": "#cloud-config\nhostname: instance_1.example.com\nfqdn: instance_1.example.com",
		},
		"Blocks": [{
			"Type": "network",
			"Labels": [],
			"Attributes": {"name": "my_network"},
			"Blocks": [],
			"line_range": {
				"endLine": 11,
				"startLine": 9,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

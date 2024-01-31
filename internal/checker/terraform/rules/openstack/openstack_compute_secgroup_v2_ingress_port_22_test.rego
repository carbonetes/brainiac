package lib.terraform.CB_TFOPENSTACK_002

test_openstack_compute_secgroup_v2_ingress_port_22_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_networking_secgroup_rule_v2",
			"unrestricted_ingress_22",
		],
		"Attributes": {
			"direction": "ingress",
			"ethertype": "IPv4",
			"port_range_max": "80",
			"port_range_min": "80",
			"protocol": "tcp",
			"remote_ip_prefix": "0.0.0.0/0",
			"security_group_id": "var.security_group_id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_openstack_compute_secgroup_v2_ingress_port_22_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"openstack_networking_secgroup_rule_v2",
			"unrestricted_ingress_22",
		],
		"Attributes": {
			"direction": "ingress",
			"ethertype": "IPv4",
			"port_range_max": "22",
			"port_range_min": "22",
			"protocol": "tcp",
			"remote_ip_prefix": "0.0.0.0/0",
			"security_group_id": "var.security_group_id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

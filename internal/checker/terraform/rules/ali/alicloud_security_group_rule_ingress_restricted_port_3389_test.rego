package lib.terraform.CB_TFALI_003

test_alicloud_security_group_rule_ingress_restricted_port_22_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "alicloud_security_group_rule",
            "allow_all_vncserver"
        ],
        "Attributes": {
            "cidr_ip": "200.0.0.1",
            "ip_protocol": "tcp",
            "nic_type": "internet",
            "policy": "accept",
            "port_range": "3389",
            "security_group_id": "alicloud_security_group.default.id",
            "type": "ingress"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_alicloud_security_group_rule_ingress_restricted_port_22_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_security_group_rule",
			"allow_all_vncserver",
		],
		"Attributes": {
			"cidr_ip": "0.0.0.0/0",
			"ip_protocol": "tcp",
			"nic_type": "internet",
			"policy": "accept",
			"port_range": "3389",
			"security_group_id": "alicloud_security_group.default.id",
			"type": "ingress",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

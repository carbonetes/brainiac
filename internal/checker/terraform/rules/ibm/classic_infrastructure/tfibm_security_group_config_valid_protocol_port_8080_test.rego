package lib.terraform.CB_TFIBM_085

import rego.v1

test_security_group_config_protocol_port_8080_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_security_group_rule",
            "allow_port_8080"
        ],
        "Attributes": {
            "direction": "ingress",
            "ether_type": "IPv4",
            "port_range_max": "8080",
            "port_range_min": "8080",
            "protocol": "tcp",
            "remote_group_id": "",
            "remote_ip": "",
            "security_group_id": "123456"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_security_group_config_protocol_port_8080_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_security_group_rule",
            "allow_port_8080"
        ],
        "Attributes": {
            "direction": "ingress",
            "ether_type": "IPv4",
            "port_range_max": "3524",
            "port_range_min": "1285",
            "protocol": "http",
            "remote_group_id": "",
            "remote_ip": "",
            "security_group_id": "123456"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

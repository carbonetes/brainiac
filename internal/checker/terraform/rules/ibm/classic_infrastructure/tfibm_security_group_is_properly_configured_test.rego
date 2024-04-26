package lib.terraform.CB_TFIBM_088

import rego.v1

test_security_group_properly_configured_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_security_group_rule",
            "allow_port_8080"
        ],
        "Attributes": {
            "direction": "ingress",
            "ether_type": "IPv6",
            "port_range_max": "8080",
            "port_range_min": "8080",
            "protocol": "tcp",
            "remote_group_id": "",
            "remote_ip": "",
            "security_group_id": 231423
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_security_group_properly_configured_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_security_group_rule",
            "allow_port_8080"
        ],
        "Attributes": {
            "direction": "ingress",
            "ether_type": "http",
            "port_range_max": "8080",
            "port_range_min": "8080",
            "protocol": "tcp",
            "remote_group_id": "",
            "remote_ip": "",
            "security_group_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

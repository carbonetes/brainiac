package lib.terraform.CB_TFIBM_069

import rego.v1

test_vpx_connection_limit_is_set_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_service",
            "test_service"
        ],
        "Attributes": {
            "connection_limit": 4294967294,
            "destination_ip_address": "192.168.1.100",
            "destination_port": "80",
            "health_check": "HTTP",
            "name": "test_load_balancer_service",
            "usip": "NO",
            "vip_id": "vip_123456789",
            "weight": "55"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_vpx_connection_limit_is_set_pass_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_service",
            "test_service"
        ],
        "Attributes": {
            "connection_limit": 4294967295,
            "destination_ip_address": "192.168.1.100",
            "destination_port": "80",
            "health_check": "HTTP",
            "name": "test_load_balancer_service",
            "usip": "NO",
            "vip_id": "vip_123456789",
            "weight": "55"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

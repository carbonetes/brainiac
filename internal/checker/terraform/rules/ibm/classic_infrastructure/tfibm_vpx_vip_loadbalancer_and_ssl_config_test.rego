package lib.terraform.CB_TFIBM_070

import rego.v1

test_vpx_vip_lb_and_ssl_config_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_vip",
            "testacc_vip"
        ],
        "Attributes": {
            "load_balancing_method": "DESTINATIONIPHASH",
            "nad_controller_id": "1234567",
            "name": "test_load_balancer_vip",
            "security_certificate_id": "442255",
            "persistence": "SOURCEIP",
            "source_port": "80",
            "type": "SSL",
            "virtual_ip_address": "10.10.2.2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_vpx_vip_lb_and_ssl_config_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_vip",
            "testacc_vip"
        ],
        "Attributes": {
            "load_balancing_method": "DESTINATIONIPHASH",
            "nad_controller_id": "1234567",
            "name": "test_load_balancer_vip",
            "security_certificate_id": "QWERTY",
            "persistence": "SOURCEIP",
            "source_port": "80",
            "type": "SSL",
            "virtual_ip_address": "10.10.2.2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
	count(result) == 1
}

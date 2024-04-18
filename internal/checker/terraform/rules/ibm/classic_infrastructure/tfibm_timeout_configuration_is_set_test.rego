package lib.terraform.CB_TFIBM_059

import rego.v1

test_timeout_configuration_is_set_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb",
            "test_lb_local"
        ],
        "Attributes": {
            "connections": "1500",
            "datacenter": "tok02",
            "dedicated": false,
            "ha_enabled": false,
            "hostname": "example.com",
            "ip_address": "10.0.0.1",
            "security_certificate_id": "45489",
            "ssl_enabled": true,
            "ssl_offload": true,
            "subnet_id": "subnet-123456789"
        },
        "Blocks": [
            {
                "Type": "timeouts",
                "Labels": [],
                "Attributes": {
                    "create": "45m"
                }
            }
        ]
    }]
	count(result) == 1
}

test_timeout_configuration_is_set_fail if {
	result := failed with input as [{
              "Type": "resource",
        "Labels": [
            "ibm_lb",
            "test_lb_local"
        ],
        "Attributes": {
            "connections": "1500",
            "datacenter": "tok02",
            "dedicated": false,
            "ha_enabled": false,
            "hostname": "example.com",
            "ip_address": "10.0.0.1",
            "security_certificate_id": "45489",
            "ssl_enabled": true,
            "ssl_offload": true,
            "subnet_id": "subnet-123456789"
        },
        "Blocks": [
            {
                "Type": "timeouts",
                "Labels": [],
                "Attributes": {
                    "create": ""
                }
            }
        ]
    }]
	count(result) == 1
}

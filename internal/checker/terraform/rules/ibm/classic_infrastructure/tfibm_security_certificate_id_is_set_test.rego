package lib.terraform.CB_TFIBM_052

import rego.v1

test_security_certificate_id_is_set_pass if {
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
            "security_certificate_id": "12345",
            "ssl_enabled": true,
            "ssl_offload": true,
            "subnet_id": "subnet-123456789"
        }
    }]
	count(result) == 1
}

test_security_certificate_id_is_set_fail if {
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
            "ssl_enabled": true,
            "ssl_offload": true,
            "subnet_id": "subnet-123456789"
        }
    }]
	count(result) == 1
}

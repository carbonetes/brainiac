package lib.terraform.CB_TFIBM_101

import rego.v1

test_load_balancer_enabled_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_service",
            "test_lb_local_service"
        ],
        "Attributes": {
            "enabled": true,
            "health_check_type": "DNS",
            "ip_address_id": "ibm_compute_vm_instance.test_server.ip_address_id",
            "port": "80",
            "service_group_id": "ibm_lb_service_group.test_service_group.service_group_id",
            "weight": "1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_load_balancer_enabled_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_service",
            "test_lb_local_service"
        ],
        "Attributes": {
            "enabled": false,
            "health_check_type": "DNS",
            "ip_address_id": "ibm_compute_vm_instance.test_server.ip_address_id",
            "port": "80",
            "service_group_id": "ibm_lb_service_group.test_service_group.service_group_id",
            "weight": "1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}
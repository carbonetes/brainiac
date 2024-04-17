package lib.terraform.CB_TFIBM_041

import rego.v1

test_health_check_config_is_http_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_autoscale_group",
            "test_scale_group"
        ],
        "Attributes": {
            "cooldown": "30",
            "health_check": {
                "type": "HTTP"
            },
            "maximum_member_count": "10",
            "minimum_member_count": "1"
        }
    }]
	count(result) == 1
}

test_health_check_config_is_http_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_autoscale_group",
            "test_scale_group"
        ],
        "Attributes": {
            "cooldown": "30",
            "health_check": {
                "type": "HTTPS"
            },
            "maximum_member_count": "10",
            "minimum_member_count": "1"
        }
    }]
	count(result) == 1
}

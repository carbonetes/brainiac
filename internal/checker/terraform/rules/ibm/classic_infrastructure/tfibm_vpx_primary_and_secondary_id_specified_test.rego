package lib.terraform.CB_TFIBM_001

import rego.v1

test_vpx_primay_and_secondary_id_specified_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_ha",
            "test_ha"
        ],
        "Attributes": {
            "primary_id": "123",
            "secondary_id": "456",
            "stay_secondary": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_vpx_primay_and_secondary_id_specified_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_lb_vpx_ha",
            "test_ha"
        ],
        "Attributes": {
            "primary_id": "",
            "secondary_id": "",
            "stay_secondary": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

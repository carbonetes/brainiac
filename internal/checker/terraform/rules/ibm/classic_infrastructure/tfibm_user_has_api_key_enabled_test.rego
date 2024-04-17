package lib.terraform.CB_TFIBM_049

import rego.v1

test_user_has_api_key_enabled_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_user",
            "joe"
        ],
        "Attributes": {
            "has_api_key": true
        }
    }]
	count(result) == 1
}

test_user_has_api_key_enabled_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_user",
            "joe"
        ],
        "Attributes": {
            "has_api_key": false
        }
    }]
	count(result) == 1
}

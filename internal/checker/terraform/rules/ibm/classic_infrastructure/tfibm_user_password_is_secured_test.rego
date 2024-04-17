package lib.terraform.CB_TFIBM_048

import rego.v1

test_user_password_is_secured_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_user",
            "joe"
        ],
        "Attributes": {
            "password": "r2aAsda@#$@"
        }
    }]
	count(result) == 1
}

test_user_password_is_secured_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_compute_user",
            "joe"
        ],
        "Attributes": {
            "password": "123"
        }
    }]
	count(result) == 1
}

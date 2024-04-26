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
            "address1": "12345 Any Street",
            "address2": "Suite #99",
            "city": "Atlanta",
            "company_name": "Comp Inc",
            "country": "US",
            "email": "joe@doe.com",
            "first_name": "Joe",
            "has_api_key": true,
            "last_name": "Doe",
            "password": "Change3Me!",
            "permissions": [
                "ACCESS_ALL_GUEST",
                "ACCESS_ALL_HARDWARE",
                "SERVER_ADD",
                "SERVER_CANCEL",
                "RESET_PORTAL_PASSWORD"
            ],
            "state": "GA",
            "timezone": "EST",
            "username": "testuser"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 1
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
            "address1": "12345 Any Street",
            "address2": "Suite #99",
            "city": "Atlanta",
            "company_name": "Comp Inc",
            "country": "US",
            "email": "joe@doe.com",
            "first_name": "Joe",
            "has_api_key": false,
            "last_name": "Doe",
            "password": "Change3Me!",
            "permissions": [
                "ACCESS_ALL_GUEST",
                "ACCESS_ALL_HARDWARE",
                "SERVER_ADD",
                "SERVER_CANCEL",
                "RESET_PORTAL_PASSWORD"
            ],
            "state": "GA",
            "timezone": "EST",
            "username": "testuser"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 1
        }
    }]
	count(result) == 1
}

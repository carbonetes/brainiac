package lib.terraform.CB_TFIBM_009

import rego.v1

test_portal_url_are_secure_pass if {
	result := passed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_cm_object",
            "cm_object"
        ],
        "Blocks": [
            {
                "Type": "publish",
                "Labels": [],
                "Attributes": {
                    "ibm_approved": true,
                    "permit_ibm_public_publish": false,
                    "public_approved": true,
                    "portal_url": "https://example.com/portal"
                }
            },
        ]
    }]
	count(result) == 1
}

test_portal_url_are_secure_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_object",
            "cm_object"
        ],
        "Blocks": [
            {
                "Type": "publish",
                "Labels": [],
                "Attributes": {
                    "ibm_approved": true,
                    "permit_ibm_public_publish": true,
                    "public_approved": true,
                    "portal_url": "http://example.com/portal"
                }
            },
        ]
    }]
	count(result) == 1
}

package lib.terraform.CB_TFIBM_008

import rego.v1

test_permission_properly_restricted_pass if {
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
                }
            },
        ]
    }]
	count(result) == 1
}

test_permission_properly_restricted_fail if {
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
                }
            },
        ]
    }]
	count(result) == 1
}

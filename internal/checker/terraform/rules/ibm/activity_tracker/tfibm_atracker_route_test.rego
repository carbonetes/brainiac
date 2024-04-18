package lib.terraform.CB_TFIBM_013

import rego.v1 

test_tfibm_atracker_route_name_is_properly_set_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_route",
            "atracker_route"
        ],
        "Attributes": {
            "name": "my-route"
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "locations": [
                        "us-south",
                        "global"
                    ],
                    "target_ids": "ibm_atracker_target.atracker_target.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 6,
                    "startLine": 3
                }
            },
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "locations": [
                        "us-east"
                    ],
                    "target_ids": "ibm_atracker_target.atracker_target.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 7
                }
            },
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "create_before_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_atracker_route_name_is_not_properly_set_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_route",
            "atracker_route"
        ],
        "Attributes": {
            "name": ""
        },
        "Blocks": [
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "locations": [
                        "us-south",
                        "global"
                    ],
                    "target_ids": "ibm_atracker_target.atracker_target.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 6,
                    "startLine": 3
                }
            },
            {
                "Type": "rules",
                "Labels": [],
                "Attributes": {
                    "locations": [
                        "us-east"
                    ],
                    "target_ids": "ibm_atracker_target.atracker_target.id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 7
                }
            },
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "create_before_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }
]
	count(result) == 1
}
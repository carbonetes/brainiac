package lib.terraform.CB_TFIBM_021

import rego.v1 

test_tfibm_atracker_target_service_to_service_enabled_passed if {
	result := passed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_target",
            "atracker_logdna_target"
        ],
        "Attributes": {
            "name": "my-logdna-target",
            "region": "us-south",
            "service_to_service_enabled": false,
            "target_type": "logdna",
            "api_key": "1234567890"
        },
        "Blocks": [
            {
                "Type": "logdna_endpoint",
                "Labels": [],
                "Attributes": {
                    "ingestion_key": "xxxxxxxxxxxxxx",
                    "target_crn": "crn:v1:bluemix:public:logdna:us-south:a/11111111111111111111111111111111:22222222-2222-2222-2222-222222222222::"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 23,
            "startLine": 13
        }
    }
]
	count(result) == 1
}

test_tfibm_atracker_target_service_to_service_enabled_failed if {
    result := failed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_target",
            "atracker_logdna_target"
        ],
        "Attributes": {
            "name": "my-logdna-target",
            "region": "us-south",
            "service_to_service_enabled": true,
            "target_type": "logdna",
            "api_key": "1234567890"
        },
        "Blocks": [
            {
                "Type": "logdna_endpoint",
                "Labels": [],
                "Attributes": {
                    "ingestion_key": "xxxxxxxxxxxxxx",
                    "target_crn": "crn:v1:bluemix:public:logdna:us-south:a/11111111111111111111111111111111:22222222-2222-2222-2222-222222222222::"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 23,
            "startLine": 13
        }
    }
]
    count(result) == 1
}
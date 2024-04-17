package lib.terraform.CB_TFIBM_040

import rego.v1 

test_tfibm_app_config_segment_guid_not_hardcoded_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_app_config_segment",
            "app_config_segment"
        ],
        "Attributes": {
            "description": "description",
            "guid": "test",
            "tags": "tags"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_app_config_segment_guid_hardcoded_failed if {
    result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_app_config_segment",
            "app_config_segment"
        ],
        "Attributes": {
            "description": "description",
            "guid": "27211153-c118-4116-8116-b811fbc31111",
            "tags": "tags"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }
]
    count(result) == 1
}
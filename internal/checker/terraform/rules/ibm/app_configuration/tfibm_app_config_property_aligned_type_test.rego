package lib.terraform.CB_TFIBM_038

import rego.v1 

test_tfibm_app_config_property_aligned_type_aligned_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_app_config_property",
            "app_config_property"
        ],
        "Attributes": {
            "disabled_value": "disabled_value",
            "enabled_value": "enabled_value",
            "environment_id": "environment_id",
            "feature_id": "feature_id",
            "guid": "guid",
            "name": "name",
            "rollout_percentage": "rollout_percentage",
            "tags": "tags",
            "type": "STRING"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_app_config_property_aligned_type_not_aligned_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "ibm_app_config_property",
                "app_config_property"
            ],
            "Attributes": {
                "disabled_value": "disabled_value",
                "enabled_value": "enabled_value",
                "environment_id": "environment_id",
                "feature_id": "feature_id",
                "guid": "guid",
                "name": "name",
                "rollout_percentage": "rollout_percentage",
                "tags": "tags",
                "type": "NUMERIC",
                "value": "not_a_number"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 11,
                "startLine": 1
            }
        }
    ]
	count(result) == 1
}
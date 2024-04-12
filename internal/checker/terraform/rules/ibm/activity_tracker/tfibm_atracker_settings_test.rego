package lib.terraform.CB_TFIBM_012

import rego.v1 

test_tfibm_atracker_settings_backup_region_is_set_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_settings",
            "atracker_settings"
        ],
        "Attributes": {
            "default_targets": "ibm_atracker_target.atracker_target.id",
            "metadata_region_backup": "us-east",
            "metadata_region_primary": "us-south",
            "permitted_target_regions": "us-south",
            "private_api_endpoint_only": false
        },
        "Blocks": [
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "create_before_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_atracker_settings_backup_region_is_not_set_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_atracker_settings",
            "atracker_settings"
        ],
        "Attributes": {
            "default_targets": "ibm_atracker_target.atracker_target.id",
            "metadata_region_backup": "",
            "metadata_region_primary": "us-south",
            "permitted_target_regions": "us-south",
            "private_api_endpoint_only": false
        },
        "Blocks": [
            {
                "Type": "lifecycle",
                "Labels": [],
                "Attributes": {
                    "create_before_destroy": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }
]
	count(result) == 1
}
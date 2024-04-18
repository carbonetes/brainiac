package lib.terraform.CB_TFIBM_005

import rego.v1

test_trusted_profile_properly_defined_pass if {
	result := passed with input as [{
  "Type": "resource",
        "Labels": [
            "ibm_cm_catalog",
            "cm_catalog"
        ],
        "Attributes": {
            "catalog_banner_url": "banner image url",
            "catalog_icon_url": "icon url",
            "disabled": false,
            "kind": "offering",
            "label": "catalog_label",
            "resource_group_id": "resource_group_id",
            "short_description": "catalog description",
            "tags": [
                "catalog",
                "tags"
            ]
        },
        "Blocks": [
            {
                "Type": "target_account_contexts",
                "Labels": [],
                "Attributes": {
                    "api_key": "api_key",
                    "label": "target_account_label",
                    "name": "target_account_name",
                    "project_id": "project_id"
                },
                "Blocks": [
                    {
                    "Type": "trusted_profile",
                    "Labels": [],
                    "Attributes": {
                        "target_service_id": "123456",
                        "trusted_profile_id": "78910112"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 16
                    }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 21,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_trusted_profile_properly_defined_fail if {
	result := failed with input as [{
       "Type": "resource",
        "Labels": [
            "ibm_cm_catalog",
            "cm_catalog"
        ],
        "Attributes": {
            "catalog_banner_url": "banner image url",
            "catalog_icon_url": "icon url",
            "disabled": false,
            "kind": "offering",
            "label": "catalog_label",
            "resource_group_id": "resource_group_id",
            "short_description": "catalog description",
            "tags": [
                "catalog",
                "tags"
            ]
        },
        "Blocks": [
            {
                "Type": "target_account_contexts",
                "Labels": [],
                "Attributes": {
                    "api_key": "api_key",
                    "label": "target_account_label",
                    "name": "target_account_name",
                    "project_id": "project_id"
                },
                "Blocks": [
                    {
                    "Type": "trusted_profile",
                    "Labels": [],
                    "Attributes": {
                        "target_service_id": "",
                        "trusted_profile_id": ""
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 19,
                        "startLine": 16
                    }
                    }
                ],
                "line_range": {
                    "endLine": 20,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 21,
            "startLine": 1
        }
    }]
	count(result) == 1
}

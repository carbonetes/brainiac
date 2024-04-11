package lib.terraform.CB_TFIBM_003

import rego.v1

test_api_key_and_product_id_is_present_pass if {
	result := passed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_catalog",
                "cm_catalog"
            ],
            "Attributes": {
                "label": "ibm_cm_catalog.cm_catalog",
                "catalog_banner_url": "https://example.com/banner.jpg",
                "catalog_icon_url": "https://example.com/icon.jpg",
            },
            "Blocks": [
                {
                    "Type": "target_account_contexts",
                    "Attributes": {
                        "label": "ibm_cm_catalog.cm_catalog.target_account_contexts",
                        "api_key": "api_key_123",
                        "name": "sample_account",
                        "project_id": "project_987"
                    }
                }
            ]
    }]
	count(result) == 1
}

test_api_key_and_product_id_is_present_fail if {
	result := failed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_catalog",
                "cm_catalog"
            ],
            "Attributes": {
                "label": "ibm_cm_catalog.cm_catalog",
                "catalog_banner_url": "https://example.com/banner.jpg",
                "catalog_icon_url": "https://example.com/icon.jpg",
            },
            "Blocks": [
                {
                    "Type": "target_account_contexts",
                    "Attributes": {
                        "label": "ibm_cm_catalog.cm_catalog.target_account_contexts",
                        "name": "sample_account",
                    }
                }
            ]
    }]
	count(result) == 1
}

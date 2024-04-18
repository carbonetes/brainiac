package lib.terraform.CB_TFIBM_004

import rego.v1

test_url_banner_and_icon_is_https_pass if {
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
    }]
	count(result) == 1
}

test_url_banner_and_icon_is_https_fail if {
	result := failed with input as [{
            "Type": "resource",
            "Labels": [
                "ibm_cm_catalog",
                "cm_catalog"
            ],
            "Attributes": {
                "label": "ibm_cm_catalog.cm_catalog",
                "catalog_banner_url": "http://example.com/banner.jpg",
                "catalog_icon_url": "http://example.com/icon.jpg",
            },
    }]
	count(result) == 1
}
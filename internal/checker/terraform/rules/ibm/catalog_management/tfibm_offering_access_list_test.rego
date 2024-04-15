package lib.terraform.CB_TFIBM_016

import rego.v1

test_offering_is_using_https_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering",
            "cm_offering"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "name": "my_offering",
            "offering_docs_url": "https://example.com/docs",
            "offering_icon_url": "https://example.com/icon.png",
            "offering_id": "offering456",
            "share_with_access_list": [
                "-ent-123",
                "-entgrp-456"
            ],
            "product_kind": "solution"
        }
    }]
	count(result) == 1
}

test_offering_is_using_https_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_offering",
            "cm_offering"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "name": "my_offering",
            "offering_docs_url": "http://example.com/docs",
            "offering_icon_url": "http://example.com/icon.png",
            "offering_id": "offering456",
            "share_with_access_list": [
                "-some-123",
                "-random-456"
            ],
            "product_kind": "solution"
        }
    }]
	count(result) == 1
}

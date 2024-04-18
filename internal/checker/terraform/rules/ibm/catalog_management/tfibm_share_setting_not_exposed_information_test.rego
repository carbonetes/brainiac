package lib.terraform.CB_TFIBM_015

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
            "product_kind": "solution",
            "share_enabled": false,
            "share_with_all": false,
            "share_with_ibm": false,
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
            "offering_docs_url": "https://example.com/docs",
            "offering_icon_url": "https://example.com/icon.png",
            "offering_id": "offering456",
            "product_kind": "solution",
            "share_enabled": true,
            "share_with_all": true,
            "share_with_ibm": true,
        }
    }]
	count(result) == 1
}

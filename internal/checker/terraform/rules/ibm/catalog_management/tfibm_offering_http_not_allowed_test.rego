package lib.terraform.CB_TFIBM_014

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
            "product_kind": "solution"
        },
        "Blocks": [
            {
                "Type": "media",
                "Labels": [],
                "Attributes": {
                    "api_url": "https://example.com/media",
                    "caption": "Media caption",
                    "caption_i18n": {
                        "en": "Media caption",
                        "fr": "Légende des médias"
                    },
                    "thumbnail_url": "https://example.com/thumbnail.png",
                    "type": "image",
                    "url": "https://example.com/media/full"
                },
                "Blocks": [
                    {
                        "Type": "url_proxy",
                        "Labels": [],
                        "Attributes": {
                            "sha": "abc123",
                            "url": "https://example.com/proxy"
                        }
                    }
                ]
            }
        ]
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
            "product_kind": "solution"
        },
        "Blocks": [
            {
                "Type": "media",
                "Labels": [],
                "Attributes": {
                    "api_url": "http://example.com/media",
                    "caption": "Media caption",
                    "caption_i18n": {
                        "en": "Media caption",
                        "fr": "Légende des médias"
                    },
                    "thumbnail_url": "http://example.com/thumbnail.png",
                    "type": "image",
                    "url": "http://example.com/media/full"
                },
                "Blocks": [
                    {
                        "Type": "url_proxy",
                        "Labels": [],
                        "Attributes": {
                            "sha": "abc123",
                            "url": "http://example.com/proxy"
                        }
                    }
                ]
            }
        ]
    }]
	count(result) == 1
}

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
            "deprecate": false,
            "hidden": false,
            "keywords": [
                "keyword1",
                "keyword2"
            ],
            "label": "My Offering",
            "long_description": "This is a long description of my offering.",
            "name": "my_offering",
            "offering_docs_url": "https://example.com/docs",
            "offering_icon_url": "https://example.com/icon.png",
            "offering_id": "offering456",
            "product_kind": "solution",
            "share_enabled": false,
            "share_with_access_list": [
                "-ent-123",
                "-entgrp-456"
            ],
            "share_with_all": false,
            "share_with_ibm": false,
            "short_description": "Short description",
            "tags": [
                "tag1",
                "tag2"
            ]
        },
        "Blocks": [
        {
            "Type": "provider_info",
            "Labels": [],
            "Attributes": {
                "id": "provider123",
                "name": "Provider Name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 11
            }
        },
        {
            "Type": "features",
            "Labels": [],
            "Attributes": {
                "description": "Feature description",
                "description_i18n": {
                "en": "Feature description",
                "fr": "Description de la fonctionnalité"
                },
                "title": "Feature Title",
                "title_i18n": {
                "en": "Feature Title",
                "fr": "Titre de la fonctionnalité"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 16
            }
        },
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
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 30
            }
            }
            ],
            "line_range": {
                "endLine": 34,
                "startLine": 23
            }
        }
        ],
        "line_range": {
        "endLine": 44,
        "startLine": 1
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
            "deprecate": false,
            "hidden": false,
            "keywords": [
                "keyword1",
                "keyword2"
            ],
            "label": "My Offering",
            "long_description": "This is a long description of my offering.",
            "name": "my_offering",
            "offering_docs_url": "https://example.com/docs",
            "offering_icon_url": "https://example.com/icon.png",
            "offering_id": "offering456",
            "product_kind": "solution",
            "share_enabled": true,
            "share_with_access_list": [
                "-ent-123",
                "-entgrp-456"
            ],
            "share_with_all": true,
            "share_with_ibm": true,
            "short_description": "Short description",
            "tags": [
                "tag1",
                "tag2"
            ]
        },
        "Blocks": [
        {
            "Type": "provider_info",
            "Labels": [],
            "Attributes": {
                "id": "provider123",
                "name": "Provider Name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 11
            }
        },
        {
            "Type": "features",
            "Labels": [],
            "Attributes": {
                "description": "Feature description",
                "description_i18n": {
                "en": "Feature description",
                "fr": "Description de la fonctionnalité"
                },
                "title": "Feature Title",
                "title_i18n": {
                "en": "Feature Title",
                "fr": "Titre de la fonctionnalité"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 21,
                "startLine": 16
            }
        },
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
            },
            "Blocks": [],
            "line_range": {
                "endLine": 33,
                "startLine": 30
            }
            }
            ],
            "line_range": {
                "endLine": 34,
                "startLine": 23
            }
        }
        ],
        "line_range": {
        "endLine": 44,
        "startLine": 1
        }
    }]
	count(result) == 1
}

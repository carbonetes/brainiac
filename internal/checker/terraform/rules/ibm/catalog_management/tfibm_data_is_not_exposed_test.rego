package lib.terraform.CB_TFIBM_006

import rego.v1

test_data_is_not_exposed_pass if {
	result := passed with input as [ {
        "Type": "resource",
        "Labels": [
            "ibm_cm_object",
            "cm_object"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "kind": "preset_configuration",
            "label": "Object Label",
            "name": "object_name",
            "parent_id": "us-south",
            "short_description": "short description",
            "tags": [
                "tag1",
                "tag2"
            ]
        },
        "Blocks": [
            {
                "Type": "publish",
                "Labels": [],
                "Attributes": {
                    "ibm_approved": true,
                    "permit_ibm_public_publish": true,
                    "portal_approval_record": "portal_approval_123",
                    "portal_url": "https://example.com/portal",
                    "public_approved": true,
                    "rev": "cloudant_revision_123",
                    "short_description": "This is a short description"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 11
                }
            },
            {
                "Type": "state",
                "Labels": [],
                "Attributes": {
                    "current": "new",
                    "current_entered": "2024-04-11T00:00:00Z",
                    "pending": "validated",
                    "pending_requested": "2024-04-11T00:00:00Z",
                    "previous": "new"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_data_is_not_exposed_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_object",
            "cm_object"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "kind": "preset_configuration",
            "label": "Object Label",
            "name": "object_name",
            "parent_id": "us-south",
            "data": "${jsonencode(file(\"data.json\"))}",
            "short_description": "short description",
            "tags": [
                "tag1",
                "tag2"
            ]
        },
        "Blocks": [
            {
                "Type": "publish",
                "Labels": [],
                "Attributes": {
                    "ibm_approved": true,
                    "permit_ibm_public_publish": true,
                    "portal_approval_record": "portal_approval_123",
                    "portal_url": "https://example.com/portal",
                    "public_approved": true,
                    "rev": "cloudant_revision_123",
                    "short_description": "This is a short description"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 11
                }
            },
            {
                "Type": "state",
                "Labels": [],
                "Attributes": {
                    "current": "new",
                    "current_entered": "2024-04-11T00:00:00Z",
                    "pending": "validated",
                    "pending_requested": "2024-04-11T00:00:00Z",
                    "previous": "new"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 28,
            "startLine": 1
        }
    }]
	count(result) == 1
}
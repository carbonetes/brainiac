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
        }
    }]
	count(result) == 1
}

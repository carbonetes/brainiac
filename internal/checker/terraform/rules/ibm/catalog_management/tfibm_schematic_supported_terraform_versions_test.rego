package lib.terraform.CB_TFIBM_036

import rego.v1

test_schematic_supported_terraform_versions_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_validation",
            "cm_version_validation"
        ],
        "Attributes": {
            "region": "us-south",
            "revalidate_if_validated": false,
            "version_locator": "example_version_locator",
            "schematics": {
                "name": "example_workspace_name",
                "description": "Example workspace description",
                "resource_group_id": "example_resource_group_id",
                "terraform_version": "v1.5.7",
                "region": "us-south",
            }
        }
    }]
	count(result) == 1
}

test_schematic_supported_terraform_versions_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_validation",
            "cm_version_validation"
        ],
        "Attributes": {
            "region": "us-south",
            "revalidate_if_validated": false,
            "version_locator": "example_version_locator",
            "schematics": {
                "name": "example_workspace_name",
                "description": "Example workspace description",
                "resource_group_id": "example_resource_group_id",
                "terraform_version": "v1.2.6",
                "region": "us-south",
            }
        }
    }]
	count(result) == 1
}

package lib.terraform.CB_TFIBM_037

import rego.v1

test_auth_token_not_exposed_pass if {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_version",
            "cm_version"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "deprecate": false,
            "include_config": true,
            "install_kind": "simple",
            "target_version": "1.0.0",
            "terraform_version": "0.12.29",
            "usage": "Test usage",
            "working_directory": "/path/to/working/directory",
            "x_auth_token": "your_auth_token"
        }
    }]
	count(result) == 1
}

test_auth_token_not_exposed_fail if {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "ibm_cm_version",
            "cm_version"
        ],
        "Attributes": {
            "catalog_id": "catalog123",
            "deprecate": false,
            "include_config": true,
            "install_kind": "simple",
            "target_version": "1.0.0",
            "terraform_version": "0.12.29",
            "usage": "Test usage",
            "working_directory": "/path/to/working/directory",
            "x_auth_token": ""
        }
    }]
	count(result) == 1
}

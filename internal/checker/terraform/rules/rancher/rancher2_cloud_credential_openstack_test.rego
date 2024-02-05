package lib.terraform.CB_TFRAN_055

test_rancher2_cloud_credential_openstack_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "openstack"
        ],
        "Attributes": {
            "description": "OpenStack Credential Test",
            "name": "openstack-credential"
        },
        "Blocks": [
            {
                "Type": "openstack_credential_config",
                "Labels": [],
                "Attributes": {
                    "password": "<your_openstack_password>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_openstack_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "openstack"
        ],
        "Attributes": {
            "description": "OpenStack Credential Test",
            "name": "openstack-credential"
        },
        "Blocks": [
            {
                "Type": "openstack_credential_config",
                "Labels": [],
                "Attributes": {
                    "password": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
    count(result) == 1
}
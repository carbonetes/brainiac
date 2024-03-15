package lib.terraform.CB_TFRAN_048

test_rancher2_cloud_credential_drivers_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "foo"
        ],
        "Attributes": {
            "description": "foo test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "amazonec2_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<AWS_ACCESS_KEY>",
                    "secret_key": "<AWS_SECRET_KEY>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_drivers_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "foo"
        ],
        "Attributes": {
            "description": "foo test",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "not_your_amazonec2_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<AWS_ACCESS_KEY>",
                    "secret_key": "<AWS_SECRET_KEY>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 2
        }
    }]
    count(result) == 1
}
package lib.terraform.CB_TFRAN_053

test_rancher2_cloud_credential_linode_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "insecure": false,
            "token": "your-rancher-api-token",
            "url": "https://your-rancher-server-url.com"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "linode"
        ],
        "Attributes": {
            "description": "Linode Cloud Credential",
            "name": "linode-credential"
        },
        "Blocks": [
            {
                "Type": "linode_credential_config",
                "Labels": [],
                "Attributes": {
                    "token": "your-linode-api-token"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 8
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_linode_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "rancher2"
        ],
        "Attributes": {
            "insecure": false,
            "token": "your-rancher-api-token",
            "url": "https://your-rancher-server-url.com"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "linode"
        ],
        "Attributes": {
            "description": "Linode Cloud Credential",
            "name": "linode-credential"
        },
        "Blocks": [
            {
                "Type": "linode_credential_config",
                "Labels": [],
                "Attributes": {
                    "token": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 8
        }
    }]
    count(result) == 1
}
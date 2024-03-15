package lib.terraform.CB_TFRAN_051

test_rancher2_cloud_credential_digitalocean_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example DigitalOcean Cloud Credential",
            "name": "example-digitalocean-credential"
        },
        "Blocks": [
            {
                "Type": "digitalocean_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_token": "<YOUR_DIGITALOCEAN_ACCESS_TOKEN>"
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

test_rancher2_cloud_credential_digitalocean_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "example"
        ],
        "Attributes": {
            "description": "Example DigitalOcean Cloud Credential",
            "name": "example-digitalocean-credential"
        },
        "Blocks": [
            {
                "Type": "digitalocean_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_token": ""
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
package lib.terraform.CB_TFRAN_056

test_rancher2_cloud_credential_s3_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "s3_credential"
        ],
        "Attributes": {
            "description": "Rancher Cloud Credential for S3",
            "name": "s3-credential"
        },
        "Blocks": [
            {
                "Type": "s3_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<YOUR_ACCESS_KEY>",
                    "default_bucket": "<YOUR_DEFAULT_BUCKET>",
                    "default_endpoint": "<YOUR_DEFAULT_ENDPOINT>",
                    "default_endpoint_ca": "<YOUR_DEFAULT_ENDPOINT_CA>",
                    "default_folder": "<YOUR_DEFAULT_FOLDER>",
                    "default_region": "<YOUR_DEFAULT_REGION>",
                    "default_skip_ssl_verify": false,
                    "secret_key": "<YOUR_SECRET_KEY>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_s3_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "s3_credential"
        ],
        "Attributes": {
            "description": "Rancher Cloud Credential for S3",
            "name": "s3-credential"
        },
        "Blocks": [
            {
                "Type": "s3_credential_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "",
                    "default_bucket": "<YOUR_DEFAULT_BUCKET>",
                    "default_endpoint": "<YOUR_DEFAULT_ENDPOINT>",
                    "default_endpoint_ca": "<YOUR_DEFAULT_ENDPOINT_CA>",
                    "default_folder": "<YOUR_DEFAULT_FOLDER>",
                    "default_region": "<YOUR_DEFAULT_REGION>",
                    "default_skip_ssl_verify": false,
                    "secret_key": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 1
        }
    }]
    count(result) == 1
}
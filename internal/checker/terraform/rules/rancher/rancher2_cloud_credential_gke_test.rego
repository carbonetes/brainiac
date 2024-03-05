package lib.terraform.CB_TFRAN_052

test_rancher2_cloud_credential_gke_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "gke_credential"
        ],
        "Attributes": {
            "description": "Google Kubernetes Engine Credential",
            "name": "gke-credential"
        },
        "Blocks": [
            {
                "Type": "googlekubernetesengine_credential_config",
                "Labels": [],
                "Attributes": {
                    "auth_encoded_json": "<your_base64_encoded_gcp_credentials>"
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

test_rancher2_cloud_credential_gke_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "gke_credential"
        ],
        "Attributes": {
            "description": "Google Kubernetes Engine Credential",
            "name": "gke-credential"
        },
        "Blocks": [
            {
                "Type": "googlekubernetesengine_credential_config",
                "Labels": [],
                "Attributes": {
                    "auth_encoded_json": ""
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
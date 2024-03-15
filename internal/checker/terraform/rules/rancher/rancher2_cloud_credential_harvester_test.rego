package lib.terraform.CB_TFRAN_054

test_rancher2_cloud_credential_harvester_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "harvester"
        ],
        "Attributes": {
            "description": "Harvester Credential Test",
            "name": "harvester-credential"
        },
        "Blocks": [
            {
                "Type": "harvester_credential_config",
                "Labels": [],
                "Attributes": {
                    "cluster_id": "<your_cluster_id>",
                    "cluster_type": "imported",
                    "kubeconfig_content": "<your_kubeconfig_content>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cloud_credential_harvester_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "harvester"
        ],
        "Attributes": {
            "description": "Harvester Credential Test",
            "name": "harvester-credential"
        },
        "Blocks": [
            {
                "Type": "harvester_credential_config",
                "Labels": [],
                "Attributes": {
                    "cluster_id": "",
                    "cluster_type": "",
                    "kubeconfig_content": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
    count(result) == 1
}
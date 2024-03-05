package lib.terraform.CB_TFRAN_068

test_rancher2_cluster_gke_config_v2_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cloud_credential",
            "foo-google"
        ],
        "Attributes": {
            "description": "Terraform cloudCredential acceptance test",
            "name": "foo-pke"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform GKE cluster",
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "oke_config",
                "Labels": [],
                "Attributes": {
                    "compartment_id": "<compartment_id>",
                    "kubernetes_version": "<kubernetes_version>",
                    "node_image": "<node_image>",
                    "node_shape": "<node_shape>",
                    "private_key_contents": "<private_key_contents>",
                    "region": "<region>",
                    "tenancy_id": "<tenancy_id>",
                    "user_ocid": "<user_ocid>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 9
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 6
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_gke_config_v2_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster",
            "foo-custom"
        ],
        "Attributes": {
            "description": "Foo rancher2 custom cluster",
            "name": "foo-custom"
        },
        "Blocks": [
            {
                "Type": "oke_config",
                "Labels": [],
                "Attributes": {
                    "compartment_id": "<compartment_id>",
                    "kubernetes_version": "<kubernetes_version>",
                    "node_image": "<node_image>",
                    "node_shape": "<node_shape>",
                    "private_key_contents": "<private_key_contents>",
                    "region": "<region>",
                    "tenancy_id": "<tenancy_id>",
                    "user_ocid": "<user_ocid>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 9
                }
            },
            {
                "Type": "aks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo-aks.id",
                    "imported": true,
                    "resource_group": "<RESOURCE_GROUP>",
                    "resource_location": "<RESOURCE_LOCATION>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 30,
                    "startLine": 25
                }
            }
        ],
        "line_range": {
            "endLine": 31,
            "startLine": 2
        }
    }]
    count(result) == 1
}
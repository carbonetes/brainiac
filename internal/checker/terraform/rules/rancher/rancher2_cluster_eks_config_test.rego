package lib.terraform.CB_TFRAN_064

test_rancher2_cluster_eks_config_passed {
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
                    "endLine": 7,
                    "startLine": 4
                }
            }
        ],
        "line_range": {
            "endLine": 8,
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
            "description": "Terraform EKS cluster",
            "name": "foo",
            "private_access": true,
            "public_access": true
        },
        "Blocks": [
            {
                "Type": "eks_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<access_key>",
                    "kubernetes_version": "<kubernetes_version>",
                    "secret_key": "<secret_key>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_eks_config_failed {
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
                "Type": "eks_config",
                "Labels": [],
                "Attributes": {
                    "access_key": "<access_key>",
                    "kubernetes_version": "<kubernetes_version>",
                    "secret_key": "<secret_key>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 12
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
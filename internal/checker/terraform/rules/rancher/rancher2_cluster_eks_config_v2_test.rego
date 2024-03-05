package lib.terraform.CB_TFRAN_065

test_rancher2_cluster_eks_config_v2_passed {
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
            "name": "foo"
        },
        "Blocks": [
            {
                "Type": "eks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo.id",
                    "kubernetes_version": "1.24",
                    "logging_types": [
                        "audit",
                        "api"
                    ],
                    "private_access": true,
                    "public_access": true,
                    "region": "<EKS_REGION>"
                },
                "Blocks": [
                    {
                        "Type": "node_groups",
                        "Labels": [],
                        "Attributes": {
                            "desired_size": "3",
                            "max_size": "5",
                            "name": "node_group1"
                        },
                        "Blocks": [
                            {
                                "Type": "launch_template",
                                "Labels": [],
                                "Attributes": {
                                    "id": "<EC2_LAUNCH_TEMPLATE_ID>",
                                    "version": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 24,
                                    "startLine": 21
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 17
                        }
                    }
                ],
                "line_range": {
                    "endLine": 28,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 29,
            "startLine": 9
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_eks_config_v2_failed {
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
                "Type": "eks_config_v2",
                "Labels": [],
                "Attributes": {
                    "cloud_credential_id": "rancher2_cloud_credential.foo.id",
                    "kubernetes_version": "1.24",
                    "logging_types": [
                        "audit",
                        "api"
                    ],
                    "private_access": true,
                    "public_access": true,
                    "region": "<EKS_REGION>"
                },
                "Blocks": [
                    {
                        "Type": "node_groups",
                        "Labels": [],
                        "Attributes": {
                            "desired_size": "3",
                            "max_size": "5",
                            "name": "node_group1"
                        },
                        "Blocks": [
                            {
                                "Type": "launch_template",
                                "Labels": [],
                                "Attributes": {
                                    "id": "<EC2_LAUNCH_TEMPLATE_ID>",
                                    "version": "1"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 24,
                                    "startLine": 21
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 25,
                            "startLine": 17
                        }
                    }
                ],
                "line_range": {
                    "endLine": 28,
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
package lib.terraform.CB_TFK8S_030

test_kubernetes_cluster_role_binding_default_not_used_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_service_account",
            "default"
        ],
        "Attributes": {
            "automount_service_account_token": false
        },
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "kubernetes_cluster_role_binding",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "terraform-example"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 9
                }
            },
            {
                "Type": "role_ref",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "ClusterRole",
                    "name": "cluster-admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 12
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "User",
                    "name": "admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 17
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "kind": "NotServiceAccount",
                    "name": "Notdefault",
                    "namespace": "kube-system"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 26,
                    "startLine": 22
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "Group",
                    "name": "system:masters"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 31,
                    "startLine": 27
                }
            }
        ],
        "line_range": {
            "endLine": 32,
            "startLine": 8
        }
    }]
	count(result) == 1
}

test_kubernetes_cluster_role_binding_default_not_used_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_service_account",
            "default"
        ],
        "Attributes": {
            "automount_service_account_token": false
        },
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "kubernetes_cluster_role_binding",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "terraform-example"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 9
                }
            },
            {
                "Type": "role_ref",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "ClusterRole",
                    "name": "cluster-admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 12
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "User",
                    "name": "admin"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 17
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "kind": "ServiceAccount",
                    "name": "default",
                    "namespace": "kube-system"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 26,
                    "startLine": 22
                }
            },
            {
                "Type": "subject",
                "Labels": [],
                "Attributes": {
                    "api_group": "rbac.authorization.k8s.io",
                    "kind": "Group",
                    "name": "system:masters"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 31,
                    "startLine": 27
                }
            }
        ],
        "line_range": {
            "endLine": 32,
            "startLine": 8
        }
    }]
	count(result) == 1
}
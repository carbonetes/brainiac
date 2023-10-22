package lib.kubernetes.CB_K8S_024

# Test case for 'Cluster Role'

test_clusterrole_passed {
            result := passed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "*"
                    ],
                    "resources": [
                        "*",
                        "serviceccounts"
                    ],
                    "verbs": [
                        ""
                    ]
                    }
                ]
            }

	count(result) > 0
}

test_clusterrole_failed {
            result := failed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        ""
                    ],
                    "resources": [
                        "*",
                        "serviceaccounts"
                    ],
                    "verbs": [
                        "*"
                    ]
                    }
                ]
            }

	count(result) > 0
}


# Test case for 'Role'

test_role_passed {
            result := passed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "Role",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "*"
                    ],
                    "resources": [
                        "*",
                        "serviceccounts"
                    ],
                    "verbs": [
                        ""
                    ]
                    }
                ]
            }

	count(result) > 0
}


test_role_failed {
            result := failed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "Role",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "*"
                    ],
                    "resources": [
                        "*",
                        "serviceccounts"
                    ],
                    "verbs": [
                        "impersonate"
                    ]
                    }
                ]
            }

	count(result) > 0
}
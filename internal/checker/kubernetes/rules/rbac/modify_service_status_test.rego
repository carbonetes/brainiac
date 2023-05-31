package lib.kubernetes.CB_K8S_027

test_modify_service_status_1_passed {
            result := passed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "rbac.authorization.k8s.io"
                    ],
                    "resources": [
                        "services/status"
                    ],
                    "verbs": [
                        ""
                    ]
                    }
                ]
            }

	count(result) > 0
}

test_modify_service_status_2_passed {
            result := passed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "rbac.authorization.k8s.io"
                    ],
                    "resources": [
                        "*"
                    ],
                    "verbs": [
                        ""
                    ]
                    }
                ]
            }

	count(result) > 0
}

test_modify_service_status_1_failed {
            result := failed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "rbac.authorization.k8s.io"
                    ],
                    "resources": [
                        "services/status"
                    ],
                    "verbs": [
                        "*"
                    ]
                    }
                ]
            }

	count(result) > 0
}

test_modify_service_status_2_failed {
            result := failed with input as{
                "apiVersion": "rbac.authorization.k8s.io/v1",
                "kind": "ClusterRole",
                "metadata": {
                    "name": "cluster-name"
                },
                "rules": [
                    {
                    "apiGroups": [
                        "rbac.authorization.k8s.io"
                    ],
                    "resources": [
                        "*"
                    ],
                    "verbs": [
                        "bind",
                        "update"
                    ]
                    }
                ]
            }

	count(result) > 0
}

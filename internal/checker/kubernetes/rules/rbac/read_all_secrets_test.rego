package lib.kubernetes.CB_K8S_026

test_read_all_secrets_passed {
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
                        "secrets"
                    ],
                    "verbs": [
                        ""
                    ]
                    }
                ]
            }

	count(result) > 0
}

test_read_all_secrets_failed {
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
                        "secrets"
                    ],
                    "verbs": [
                        "watch"
                    ]
                    }
                ]
            }

	count(result) > 0
}
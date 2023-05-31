package lib.kubernetes.CB_K8S_025

test_serviceaccount_inactive_PE {
            result := passed with input as{						
                        "apiVersion": "v1",
                        "kind": "RoleBinding",
                        "metadata": {
                            "name": "restricted-access"
                        },
                        "subjects": [
                            {
                            "kind": "",
                            "name": "my-service-account"
                            }
                        ],
                        "roleRef": {
                            "kind": "ClusterRole",
                            "name": "restricted-access",
                            "apiGroup": "rbac.authorization.k8s.io"
                        }
				}

	count(result) == 1
}

test_serviceaccount_active_PE {
            result := failed with input as{					
                        "apiVersion": "v1",
                        "kind": "RoleBinding",
                        "metadata": {
                            "name": "restricted-access"
                        },
                        "subjects": [
                            {
                            "kind": "Node",
                            "name": "my-node"
                            }
                        ],
                        "roleRef": {
                            "kind": "ClusterRole",
                            "name": "restricted-access",
                            "apiGroup": "rbac.authorization.k8s.io"
                        }
				}

	count(result) == 1
}
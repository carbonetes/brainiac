package lib.kubernetes.CB_K8S_056

test_token_auth_not_set {
            result := passed with input as{
                "apiVersion": "v1",
                "kind": "Pod",
                "metadata": {
                    "creationTimestamp": null,
                    "labels": {
                    "component": "kube-apiserver",
                    "tier": "control-plane"
                    },
                    "name": "kubelet",
                    "namespace": "kube-system"
                },
                "spec": {
                    "containers": [
                    {
                        "command": [
                        "kube-apiserver",
                        "--anonymous-auth=false"
                        ],
                        "image": "gcr.io/google_containers/kubelet-amd64:v1.6.0",
                        "name": "gcr"
                    }
                    ]
                }
            }

	count(result) == 1
}

test_token_auth_is_set {
            result := failed with input as{
                "apiVersion": "v1",
                "kind": "Pod",
                "metadata": {
                    "creationTimestamp": null,
                    "labels": {
                    "component": "kubelet",
                    "tier": "control-plane"
                    },
                    "name": "kubelet",
                    "namespace": "kube-system"
                },
                "spec": {
                    "containers": [
                    {
                        "command": [
                        "kube-apiserver",
                        "--token-auth-file"
                        ],
                        "image": "gcr.io/google_containers/kubelet-amd64:v1.6.0",
                        "name": "gcr"
                    }
                    ]
                }
            }

	count(result) == 1
}

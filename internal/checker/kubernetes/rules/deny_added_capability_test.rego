package lib.kubernetes.CB_K8S_106

test_added_restricted {
            result := passed with input as{						
                "apiVersion": "policy/v1beta1",
                "kind": "PodSecurityPolicy",
                "metadata": {
                    "name": "example"
                },
                "spec": {
                    "allowedHostPaths": [
                    {
                        "pathPrefix": "/dev"
                    },
                    {
                        "pathPrefix": "/run"
                    },
                    {
                        "pathPrefix": "/"
                    }
                    ],
                    "fsGroup": {
                    "rule": "RunAsAny"
                    },
                    "hostNetwork": true,
                    "privileged": true,
                    "runAsUser": {
                    "rule": "RunAsAny"
                    },
                    "seLinux": {
                    "rule": "RunAsAny"
                    },
                    "supplementalGroups": {
                    "rule": "RunAsAny"
                    },
                    "volumes": [
                    "hostPath",
                    "secret"
                    ]
                }
				}

	count(result) == 1
}

test_added_included{
            result := failed with input as{					
              "apiVersion": "policy/v1beta1",
                "kind": "PodSecurityPolicy",
                "metadata": {
                    "name": "example"
                },
                "spec": {
                    "allowedCapabilities": [
                    "NET_ADMIN",
                    "IPC_LOCK"
                    ],
                    "allowedHostPaths": [
                    {
                        "pathPrefix": "/dev"
                    },
                    {
                        "pathPrefix": "/run"
                    },
                    {
                        "pathPrefix": "/"
                    }
                    ],
                    "fsGroup": {
                    "rule": "RunAsAny"
                    },
                    "hostNetwork": true,
                    "privileged": true,
                    "runAsUser": {
                    "rule": "RunAsAny"
                    },
                    "seLinux": {
                    "rule": "RunAsAny"
                    },
                    "supplementalGroups": {
                    "rule": "RunAsAny"
                    },
                    "volumes": [
                    "hostPath",
                    "secret"
                    ]
                }
				}

	count(result) == 1
}
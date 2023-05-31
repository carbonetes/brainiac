package lib.kubernetes.CB_K8S_103

test_inactive_host_network {
            result := passed with input as{						
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "privileged": false,
                            "hostNetwork": false,
                            "seLinux": {
                            "rule": "RunAsAny"
                            },
                            "runAsUser": {
                            "rule": "RunAsAny"
                            },
                            "fsGroup": {
                            "rule": "RunAsAny"
                            },
                            "volumes": [
                            "configMap",
                            "emptyDir",
                            "projected",
                            "secret",
                            "downwardAPI",
                            "persistentVolumeClaim"
                            ]
                        }
				}

	count(result) == 1
}

test_active_host_network {
            result := failed with input as{					
                       "apiVersion": "batch/v1",
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "privileged": false,
                            "hostNetwork": true,
                            "seLinux": {
                            "rule": "RunAsAny"
                            },
                            "runAsUser": {
                            "rule": "RunAsAny"
                            },
                            "fsGroup": {
                            "rule": "RunAsAny"
                            },
                            "volumes": [
                            "configMap",
                            "emptyDir",
                            "projected",
                            "secret",
                            "downwardAPI",
                            "persistentVolumeClaim"
                            ]
                        }
				}

	count(result) == 1
}
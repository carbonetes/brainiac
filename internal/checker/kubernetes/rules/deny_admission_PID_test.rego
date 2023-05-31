package lib.kubernetes.CB_K8S_100

test_inactive_hostPID {
            result := passed with input as{						
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "hostPID": false,
                            "privileged": false,
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

test_active_hostPID {
            result := failed with input as{					
                       "apiVersion": "batch/v1",
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "hostPID": true,
                            "privileged": false,
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
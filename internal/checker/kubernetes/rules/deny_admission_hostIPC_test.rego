package lib.kubernetes.CB_K8S_102

test_inactive_hostIPC {
            result := passed with input as{						
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "hostPID": false,
                            "privileged": false,
                            "hostIPC": false,
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

test_active_hostIPC {
            result := failed with input as{					
                       "apiVersion": "batch/v1",
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "hostPID": false,
                            "privileged": false,
                            "hostIPC": true,
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
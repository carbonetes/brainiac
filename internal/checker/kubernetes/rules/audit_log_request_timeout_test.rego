package lib.kubernetes.CB_K8S_098

test_audit_valid_timeout {
            result := passed with input as{						
                        "apiVersion": "batch/v1",
                        "kind": "Job",
                        "metadata": {
                            "name": "jobs-simple-job"
                        },
                        "spec": {
                            "template": {
                            "spec": {
                                "restartPolicy": "Never",
                                "containers": [
                                {
                                    "command": [
                                    "kube-apiserver",
                                    "--request-timeout=2m3s"
                                    ],
                                    "image": "perl",
                                    "name": "jobs-simple-container"
                                }
                                ]
                            }
                            }
                        }
				}

	count(result) == 1
}

test_no_audit_invalid_timeout {
            result := failed with input as{					
                       "apiVersion": "batch/v1",
                        "kind": "Job",
                        "metadata": {
                            "name": "jobs-simple-job"
                        },
                        "spec": {
                            "template": {
                            "spec": {
                                "restartPolicy": "Never",
                                "containers": [
                                {
                                    "command": [
                                    "kube-apiserver",
                                    "--request-timeout=1"
                                    ],
                                    "image": "perl",
                                    "name": "jobs-simple-container"
                                }
                                ]
                            }
                            }
                        }
				}

	count(result) == 1
}
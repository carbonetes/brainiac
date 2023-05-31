package lib.kubernetes.CB_K8S_079

test_audit_path {
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
                                    "--audit-log-path=/path/to/log"
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

test_no_audit_path {
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
                                    "kube-apiserver"
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
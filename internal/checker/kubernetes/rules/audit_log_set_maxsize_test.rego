package lib.kubernetes.CB_K8S_090

test_valid_maxsize {
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
                                "--audit-log-maxsize=100"
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

test_invalid_maxsize{
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
                                "--audit-log-maxsize=90"
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
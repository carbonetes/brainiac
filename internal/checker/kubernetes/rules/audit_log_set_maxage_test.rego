package lib.kubernetes.CB_K8S_088

test_valid_maxage {
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
                                "--audit-log-maxage=30"
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

test_invalid_maxage {
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
                                "--audit-log-maxage=15"
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
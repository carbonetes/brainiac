package lib.kubernetes.CB_K8S_089

test_valid_maxbackup {
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
                                "--audit-log-maxbackup=10"
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

test_invalid_maxbackup{
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
                                "--audit-log-maxbackup=5"
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
package lib.kubernetes.CB_K8S_042

test_with_accountToken_not_use {
            result := passed with input as{
                            "apiVersion": "batch/v1beta1",
                            "kind": "CronJob",
                            "metadata": {
                                "name": "<name>"
                            },
                            "spec": {
                                "schedule": "<>",
                                "jobTemplate": {
                                "spec": {
                                    "template": {
                                    "spec": {
                                        "automountServiceAccountToken": false
                                    }
                                    }
                                }
                                }
                            }
                        }

	count(result) == 1
}

test_with_default_accountToken_in_use {
            result := failed with input as{
                            "apiVersion": "batch/v1beta1",
                            "kind": "CronJob",
                            "metadata": {
                                "name": "<name>"
                            },
                            "spec": {
                                "schedule": "<>",
                                "jobTemplate": {
                                "spec": {
                                    "template": {
                                    "spec": {
                                    }
                                    }
                                }
                                }
                            }
                        }

	count(result) == 1
}
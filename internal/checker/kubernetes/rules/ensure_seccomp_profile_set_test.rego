package lib.kubernetes.CB_K8S_107

test_seccomp_set {
            result := passed with input as{						
                     "apiVersion": "v1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<name>",
                            "annotations": {
                            "seccomp.security.alpha.kubernetes.io/defaultProfileName": "docker/default"
                            }
                        }
				}

	count(result) == 1
}

test_seccomp_not_set {
            result := failed with input as{					
                     "apiVersion": "v1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<name>",
                            "annotations": {
                            "seccomp.security.alpha.kubernetes.io/pod": ""
                            }
                        }
				}

	count(result) == 1
}
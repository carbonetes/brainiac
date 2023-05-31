package lib.kubernetes.CB_K8S_104

test_inactive_allow_privilege_escalation {
            result := passed with input as{						
                      "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "containers": [
                            {
                                "name": "<container name>",
                                "image": "<image>",
                                "securityContext": {
                                "allowPrivilegeEscalation": false
                                }
                            }
                            ]
                        }
				}

	count(result) == 1
}

test_active_allow_privilege_escalation {
            result := failed with input as{					
                      "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "example-podsecuritypolicy"
                        },
                        "spec": {
                            "containers": [
                            {
                                "name": "<container name>",
                                "image": "<image>",
                                "securityContext": {
                                "allowPrivilegeEscalation": true
                                }
                            }
                            ]
                        }
				}

	count(result) == 1
}
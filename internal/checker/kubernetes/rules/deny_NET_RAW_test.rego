package lib.kubernetes.CB_K8S_105

test_NET_RAW_DROPPED {
            result := passed with input as{						
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<policy name>"
                        },
                        "spec": {
                            "requiredDropCapabilities": "-NET_RAW"
                        }
				}

	count(result) == 1
}

test_NET_RAW_INCLUDED {
            result := failed with input as{					
                       "apiVersion": "policy/v1beta1",
                        "kind": "PodSecurityPolicy",
                        "metadata": {
                            "name": "<policy name>"
                        },
                        "spec": {
                            "requiredDropCapabilities": "-SOME_CAPABILITY"
                        }
				}

	count(result) == 1
}
package lib.kubernetes.CB_K8S_046

test_with_high_UID{
            result := passed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"name": "nginx"
								},
								"spec": {
									"containers": [
									{
										"name": "<container name>",
										"image": "nginx",
										"securityContext": {
											"runAsUser" : 10000
										}
									}
									]
								}
							}

	count(result) == 1
}

test_with_no_UID_set {
            result := failed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"name": "nginx"
								},
								"spec": {
									"containers": [
									{
										"name": "<container name>",
										"image": "nginx",
										"securityContext": {
											"runAsUser" : 100
										}
									}
									]
								}
							}
	count(result) == 1
}
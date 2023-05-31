package lib.kubernetes.CB_K8S_041

test_admission_of_limited_capabilities{
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
										"capabilities": {
											"drop": [
											"ALL"
											]
										}
										}
									}
									]
								}
							}

	count(result) == 1
}

test_admission_of_not_limited_capabilities {
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
										"capabilities": {
											"drop": [
												"NET_RAW"
											]
										}
										}
									}
									]
								}
							}
	count(result) == 1
}
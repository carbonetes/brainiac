package lib.kubernetes.CB_K8S_036

test_with_no_secrets {
            result := passed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"name": "nginx-pod"
								},
								"spec": {
									"containers": [
									{
										"name": "nginx",
										"image": "nginx"
									}
									],
								}
						}
	count(result) == 1
}

test_with_secrets {
            result := failed with input as{
									"apiVersion": "v1",
									"kind": "Pod",
									"metadata": {
										"name": "nginx"
									},
									"spec": {
										"containers": [
										{
											"name": "nginx",
											"image": "nginx:latest",
											"envFrom": [
											{
												"secretRef": {
												"name": "secrets"
												}
											}
											]
										}
										]
									}
								}
	count(result) == 1
}
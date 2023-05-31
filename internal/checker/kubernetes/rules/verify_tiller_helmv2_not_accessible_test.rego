package lib.kubernetes.CB_K8S_050

test_with_tiller_not_accessible {
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
										"image": "tiller",
										"args": [
											"--listen=localhost:44134"
										]
									}
									],
								}
						}
	count(result) == 1
}

test_with_tiller_is_accessible {
            result := failed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"name": "nginx-pod"
								},
								"spec": {
									"containers": [
									{
										"name": "nginx",
										"image": "tiller"
									}
									],
								}
						}
	count(result) == 1
}
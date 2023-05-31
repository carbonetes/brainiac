package lib.kubernetes.CB_K8S_044

test_with_no_tiller {
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

test_with_tiller_input {
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
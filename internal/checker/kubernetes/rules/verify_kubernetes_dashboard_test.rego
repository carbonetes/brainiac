package lib.kubernetes.CB_K8S_035

test_with_no_kubernetes_dashboard {
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

test_with_kubernetes_dashboard {
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
										"image": "kubernetes-dashboard"
									}
									],
								}
						}
	count(result) == 1
}
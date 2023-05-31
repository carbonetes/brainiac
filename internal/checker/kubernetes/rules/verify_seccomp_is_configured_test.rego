package lib.kubernetes.CB_K8S_034

test_with_seccompProfile {
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
										"image": "nginx:latest"
									}
									],
									"securityContext": {
									"seccompProfile": {
										"type": "RuntimeDefault"
									}
								}
							}
						}
	count(result) == 1
}

test_with_no_seccompProfile {
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
										"image": "nginx:latest"
									}
									],
									"securityContext": {
									"privileged" : true
									}
								}
						}
	count(result) == 1
}
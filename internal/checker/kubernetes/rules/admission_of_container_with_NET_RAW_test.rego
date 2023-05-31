package lib.kubernetes.CB_K8S_032

test_with_drop_capabilities {
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
											"NET_RAW",
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

test_with_no_drop_capabilities {
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
									}
									]
								}
							}
	count(result) == 1
}
package lib.kubernetes.CB_K8S_045

test_with_no_SYS_ADMIN_capabilities{
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

test_with_SYS_ADMIN_capabilities {
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
											"add": [
												"SYS_ADMIN"
											]
										}
										}
									}
									]
								}
							}
	count(result) == 1
}
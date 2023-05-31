package lib.kubernetes.CB_K8S_023

test_admission_of_default_capabilities{
            result := passed with input as{
						"apiVersion": "apps/v1",
						"kind": "Deployment",
						"metadata": {
							"name": "nginx-deployment",
							"namespace": "default",
							"labels": {
							"app": "nginx"
							}
						},
						"spec": {
							"template": {
							"metadata": {
								"labels": {
								"app": "nginx"
								}
							},
							"spec": {
								"containers": [
								{
									"name": "nginx",
									"imagePullPolicy": "Always",
									"image": "nginx:v1.4.4"
								}
								]
							}
							}
						}
				}

	count(result) == 1
}

test_admission_of_non_default_capabilities {
            result := failed with input as{
						"apiVersion": "apps/v1",
						"kind": "Deployment",
						"metadata": {
							"name": "nginx-deployment",
							"namespace": "default",
							"labels": {
							"app": "nginx"
							}
						},
						"spec": {
							"replicas": 3,
							"selector": {
							"matchLabels": {
								"app": "nginx"
							}
							},
							"template": {
							"metadata": {
								"labels": {
								"app": "nginx"
								}
							},
							"spec": {
								"containers": [
								{
									"name": "nginx",
									"imagePullPolicy": "Always",
									"image": "nginx:latest",
									"securityContext": {
										"capabilities": {
											"add": [
											"NET_ADMIN"
											]
										}
									}
								}
								]
							}
							}
						}
				}

	count(result) == 1
}
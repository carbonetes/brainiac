package lib.kubernetes.CB_K8S_021

test_admission_of_non_root_user_true {
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
									"image": "nginx:v1.4.4",
									"securityContext": {
										"runAsNonRoot": true
									}
								}
								]
							}
							}
						}
				}

	count(result) == 1
}

test_admission_of_not_non_root_user {
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
									"ports": [
									{
										"containerPort": 80
									}
									]
								}
								]
							}
							}
						}
				}

	count(result) == 1
}
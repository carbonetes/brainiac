package lib.kubernetes.CB_K8S_097

test_with_liveness_probe {
            result := passed with input as{
							"apiVersion": "apps/v1",
							"kind": "Deployment",
							"metadata": {
								"name": "nginx-deployment",
								"namespace": "default"
							},
							"spec": {
								"template": {
								"spec": {
									"containers": [
									{
										"name": "nginx",
										"image": "nginx:latest",
										"livenessProbe": {
											"failureThreshold": 25,
											"httpGet": {
												"path": "/actuator/health/liveness",
												"port": 8080,
												"scheme": "HTTP"
											}
										},
							}]}}}}

	count(result) == 1
}

test_with_no_liveness_probe {
            result := failed with input as{
							"apiVersion": "apps/v1",
							"kind": "Deployment",
							"metadata": {
								"name": "nginx-deployment",
								"namespace": "default"
							},
							"spec": {
								"template": {
								"spec": {
									"containers": [
									{
										"name": "nginx",
										"image": "nginx:latest",
							}]}}}}
	count(result) == 1
}
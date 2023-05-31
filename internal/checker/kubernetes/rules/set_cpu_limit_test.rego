package lib.kubernetes.CB_K8S_003

test_resource_cpu_limit {
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
										"resources": {
										"limits": {
											"cpu": "1"
										},
							}}]}}}}

	count(result) == 1
}

test_no_resource_cpu_limit {
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
package lib.kubernetes.CB_K8S_030

test_hostPort_not_specified {
            result := passed with input as{
							"apiVersion": "batch/v1",
							"kind": "CronJob",
							"metadata": {
								"name": "hello"
							},
							"spec": {
								"schedule": "* * * * *",
								"jobTemplate": {
								"spec": {
									"template": {
									"spec": {
										"containers": [
										{
											"name": "hello",
											"image": "busybox:1.28",
											"imagePullPolicy": "IfNotPresent",
											"ports": [
											{
												"containerPort": 80,
												"hostIP": "10.0.0.1",
											}
											]
										}
										]
							}}}}}}
	count(result) == 1
}

test_hostPort_specified {
            result := failed with input as{
							"apiVersion": "batch/v1",
							"kind": "CronJob",
							"metadata": {
								"name": "hello"
							},
							"spec": {
								"schedule": "* * * * *",
								"jobTemplate": {
								"spec": {
									"template": {
									"spec": {
										"containers": [
										{
											"name": "hello",
											"image": "busybox:1.28",
											"imagePullPolicy": "IfNotPresent",
											"ports": [
											{
												"containerPort": 80,
												"hostIP": "10.0.0.1",
												"hostPort": 8080
											}
											]
										}
										]
							}}}}}}
	count(result) == 1
}
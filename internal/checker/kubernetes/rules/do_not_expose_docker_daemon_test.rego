package lib.kubernetes.CB_K8S_031

test_no_docker_volume_specified {
            result := passed with input as{
									"apiVersion": "v1",
									"kind": "Pod",
									"metadata": {
										"name": "<name>"
									},
									"spec": {
										"volumes": {
										"-name": "test",
										"hostPath": {
											"path": "/shared"
										}
										}
									}
									}
	count(result) == 1
}

test_docker_volume_mounted {
            result := failed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"name": "<name>"
								},
								"spec": {
									"volumes": [
									{
										"name": "docker",
										"hostPath": {
										"path": "/var/run/docker.sock"
										}
									}
									]
								}
							}
	count(result) == 1
}
package lib.kubernetes.CB_K8S_077

test_insecure_port_is_not_set_to_zero {
            result := passed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"creationTimestamp": null,
									"labels": {
									"component": "kube-apiserver",
									"tier": "control-plane"
									},
									"name": "kube-apiserver",
									"namespace": "kube-system"
								},
								"spec": {
									"containers": [
										{
											"command": [
											"kube-apiserver",
											"--secure-port=8080"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}

	count(result) == 1
}

test_secure_port_is_set_to_zero {
            result := failed with input as{
								"apiVersion": "v1",
								"kind": "Pod",
								"metadata": {
									"creationTimestamp": null,
									"labels": {
									"component": "kube-apiserver",
									"tier": "control-plane"
									},
									"name": "kube-apiserver",
									"namespace": "kube-system"
								},
								"spec": {
									"containers": [
										{
											"command": [
											"kube-apiserver",
											"--secure-port=0"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}
	count(result) == 1
}

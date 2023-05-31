package lib.kubernetes.CB_K8S_084

test_service_account_key_file_is_set{
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
											"--secure-port=8080",
											"--service-account-key-file=/keys/key.pem"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}

	count(result) == 1
}

test_service_account_key_file_is_not_set_properly {
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
											"--secure-port=0",
											"--service-account-key-file=/|keys/key.pem"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}
	count(result) == 1
}

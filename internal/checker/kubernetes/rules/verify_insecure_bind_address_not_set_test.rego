package lib.kubernetes.CB_K8S_075

test_bind_address_is_not_set {
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
											"kube-apiserver"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}

	count(result) == 1
}

test_bind_address_is_set {
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
											"--bind-address=192.168.1.1"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}
	count(result) == 1
}

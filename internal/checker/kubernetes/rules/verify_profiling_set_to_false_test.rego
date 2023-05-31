package lib.kubernetes.CB_K8S_078

test_profiling_is_false {
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
											"--profiling=false"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}

	count(result) == 1
}

test_profiling_is_not_false {
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
											"--profiling=true"
											],
											"image": "gcr.io/google_containers/kube-apiserver-amd64:v1.6.0"
										}
									]
								}
							}
	count(result) == 1
}

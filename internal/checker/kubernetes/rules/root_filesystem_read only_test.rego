package lib.kubernetes.CB_K8S_019

test_root_file_system_read_only_true {
	result := passed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {"containers": [{
			"name": "nginx",
			"image": "nginx:latest",
			"securityContext": {"readOnlyRootFilesystem": true},
		}]}}},
	}

	count(result) == 1
}

test_root_file_system_read_only_false {
	result := failed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {"containers": [{
			"name": "nginx",
			"image": "nginx:latest",
		}]}}},
	}
	count(result) == 1
}

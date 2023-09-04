package lib.kubernetes.CB_K8S_013

test_share_host_network_disabled {
	result := passed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {"hostPID": false}}},
	}

	count(result) == 1
}

test_share_host_pid_enabled {
	result := failed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {"hostPID": true}}},
	}
	count(result) == 1
}

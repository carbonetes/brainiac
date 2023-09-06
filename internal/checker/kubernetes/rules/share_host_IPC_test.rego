package lib.kubernetes.CB_K8S_015

test_share_host_ipc_disabled {
	result := passed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {}}},
	}

	count(result) == 1
}

test_share_host_ipc_enabled {
	result := failed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
		},
		"spec": {"template": {"spec": {"hostIPC": true}}},
	}
	count(result) == 1
}

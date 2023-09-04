package lib.kubernetes.CB_K8S_016

test_deployment_with_privilege_escalation_false {
	result := passed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
			"labels": {"app": "nginx"},
		},
		"spec": {
			"replicas": 3,
			"selector": {"matchLabels": {"app": "nginx"}},
			"template": {
				"metadata": {"labels": {"app": "nginx"}},
				"spec": {"containers": [{
					"name": "nginx",
					"imagePullPolicy": "Always",
					"image": "nginx:v1.4.4",
					"securityContext": {"allowPrivilegeEscalation": false},
					"ports": [{"containerPort": 80}],
				}]},
			},
		},
	}

	count(result) == 1
}

test_deployment_without_privilege_escalation_false {
	result := failed with input as {
		"apiVersion": "apps/v1",
		"kind": "Deployment",
		"metadata": {
			"name": "nginx-deployment",
			"namespace": "default",
			"labels": {"app": "nginx"},
		},
		"spec": {
			"replicas": 3,
			"selector": {"matchLabels": {"app": "nginx"}},
			"template": {
				"metadata": {"labels": {"app": "nginx"}},
				"spec": {"containers": [{
					"name": "nginx",
					"imagePullPolicy": "Always",
					"image": "nginx:latest",
					"ports": [{"containerPort": 80}],
				}]},
			},
		},
	}

	count(result) == 1
}

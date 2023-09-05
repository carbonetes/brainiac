package lib.kubernetes.CB_K8S_010

test_deployment_image_pull_always {
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
					"ports": [{"containerPort": 80}],
				}]},
			},
		},
	}

	count(result) == 1
}

test_deployment_not_image_pull_always {
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
					"imagePullPolicy": "IfNotPresent",
					"image": "nginx:latest",
					"securityContext": {"privileged": true},
					"ports": [{"containerPort": 80}],
				}]},
			},
		},
	}

	count(result) == 1
}

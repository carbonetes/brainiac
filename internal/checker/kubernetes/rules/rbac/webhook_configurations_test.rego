package lib.kubernetes.CB_K8S_011

test_webhook_configurations_passed {
	result := passed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["admissionregistration.k8s.io"],
			"resources": [
				"*",
				"mutatingwebhookconfigurations",
			],
			"verbs": [""],
		}],
	}

	count(result) > 0
}

test_webhook_configurations_failed {
	result := failed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["admissionregistration.k8s.io"],
			"resources": [
				"*",
				"mutatingwebhookconfigurations",
			],
			"verbs": ["patch"],
		}],
	}

	count(result) > 0
}

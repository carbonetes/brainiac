package lib.kubernetes.CB_K8S_009

test_wildcard_roles_passed {
	result := passed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["admissionregistration.k8s.io"],
			"resources": [
				"",
				"mutatingwebhookconfigurations",
			],
			"verbs": ["update"],
		}],
	}

	count(result) > 0
}

test_wildcard_roles_failed {
	result := failed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["admissionregistration.k8s.io"],
			"resources": ["mutatingwebhookconfigurations"],
			"verbs": ["*"],
		}],
	}

	count(result) > 0
}

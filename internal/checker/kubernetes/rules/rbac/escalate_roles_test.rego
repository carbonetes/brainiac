package lib.kubernetes.CB_K8S_020

test_escalate_role_passed {
	result := passed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["*"],
			"resources": [
				"*",
				"serviceccounts",
			],
			"verbs": [""],
		}],
	}

	count(result) > 0
}

test_escalate_role_failed {
	result := failed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["rbac.authorization.k8s.io"],
			"resources": ["clusterroles"],
			"verbs": ["escalate"],
		}],
	}

	count(result) > 0
}

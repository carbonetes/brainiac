package lib.kubernetes.CB_K8S_018

test_rolebinding_passed {
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

test_rolebinding_failed {
	result := failed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [{
			"apiGroups": ["rbac.authorization.k8s.io"],
			"resources": ["rolebindings"],
			"verbs": ["bind"],
		}],
	}

	count(result) > 0
}

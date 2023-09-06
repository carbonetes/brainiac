package lib.kubernetes.CB_K8S_014

test_singing_certificate_request_passed {
	result := passed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [
			{
				"apiGroups": ["certificates.k8s.io"],
				"resources": [
					"*",
					"certificatesigningrequests/approval",
				],
				"verbs": ["update"],
			},
			{
				"apiGroups": ["certificates.k8s.io"],
				"resources": [
					"*",
					"signers",
				],
				"verbs": [""],
			},
		],
	}

	count(result) > 0
}

test_singing_certificate_request_failed {
	result := failed with input as {
		"apiVersion": "rbac.authorization.k8s.io/v1",
		"kind": "ClusterRole",
		"metadata": {"name": "cluster-name"},
		"rules": [
			{
				"apiGroups": ["certificates.k8s.io"],
				"resources": [
					"*",
					"certificatesigningrequests/approval",
				],
				"verbs": ["update"],
			},
			{
				"apiGroups": ["certificates.k8s.io"],
				"resources": [
					"*",
					"signers",
				],
				"verbs": ["approve"],
			},
		],
	}

	count(result) > 0
}

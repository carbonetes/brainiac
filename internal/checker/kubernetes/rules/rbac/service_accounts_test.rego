package lib.kubernetes.CB_K8S_005

test_service_account_not_in_use {
            result := passed with input as{
						"apiVersion": "v1",
                        "kind": "ServiceAccount",
                        "metadata": {
                            "name": "default",
                            "automountServiceAccountToken": false
                        }
				}

	count(result) == 1
}

test_service_account_in_use {
            result := failed with input as{
						"apiVersion": "v1",
                        "kind": "ServiceAccount",
                        "metadata": {
                            "name": "default",
                            "automountServiceAccountToken": true
                        }
				}

	count(result) == 1
}
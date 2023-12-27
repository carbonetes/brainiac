package lib.terraform.CB_TFK8S_029

test_kubernetes_service_account_default_not_used_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "kubernetes_service_account",
            "default"
        ],
        "Attributes": {
            "automount_service_account_token": false
        },
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "not-def"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_kubernetes_service_account_default_not_used_failed {
	result := failed with input as[{
        "Type": "resource",
        "Labels": [
            "kubernetes_service_account",
            "default"
        ],
        "Attributes": {
            "automount_service_account_token": true
        },
        "Blocks": [
            {
                "Type": "metadata",
                "Labels": [],
                "Attributes": {
                    "name": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 4,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}
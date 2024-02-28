package lib.terraform.CB_TFRAN_165

test_rancher2_notifier_wechat_config_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_notifier",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "description": "Terraform notifier acceptance test",
            "name": "foo",
            "send_resolved": "true"
        },
        "Blocks": [
            {
                "Type": "wechat_config",
                "Labels": [],
                "Attributes": {
                    "agent": "<YOUR_WECHAT_AGENT>",
                    "corp": "<YOUR_WECHAT_CORP>",
                    "default_recipient": "<YOUR_WECHAT_DEFAULT_RECIPIENT>",
                    "secret": "<YOUR_WECHAT_SECRET>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_notifier_wechat_config_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_notifier",
            "foo"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "description": "Terraform notifier acceptance test",
            "name": "foo",
            "send_resolved": "true"
        },
        "Blocks": [
            {
                "Type": "wechat_config",
                "Labels": [],
                "Attributes": {
                    "agent": "",
                    "corp": "",
                    "default_recipient": "",
                    "secret": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 2
        }
    }]
    count(result) == 1
}
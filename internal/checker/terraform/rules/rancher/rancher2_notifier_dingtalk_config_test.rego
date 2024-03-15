package lib.terraform.CB_TFRAN_159

test_rancher2_notifier_dingtalk_config_passed {
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
                "Type": "dingtalk_config",
                "Labels": [],
                "Attributes": {
                    "proxy_url": "http://proxy.test.io",
                    "secret": "<YOUR_DINGTALK_SECRET>",
                    "url": "<YOUR_DINGTALK_URL>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_notifier_dingtalk_config_failed {
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
                "Type": "dingtalk_config",
                "Labels": [],
                "Attributes": {
                    "proxy_url": "http://proxy.test.io",
                    "secret": "<YOUR_DINGTALK_SECRET>",
                    "url": ""
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 7
                }
            }
        ],
        "line_range": {
            "endLine": 12,
            "startLine": 2
        }
    }]
    count(result) == 1
}
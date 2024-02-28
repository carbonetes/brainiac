package lib.terraform.CB_TFRAN_163

test_rancher2_notifier_smtp_config_passed {
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
                "Type": "smtp_config",
                "Labels": [],
                "Attributes": {
                    "default_recipient": "<YOUR_SMTP_DEFAULT_RECIPIENT>",
                    "host": "<YOUR_SMTP_HOST>",
                    "port": 1,
                    "sender": "<YOUR_SMTP_SENDER>"
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

test_rancher2_notifier_smtp_config_failed {
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
                "Type": "smtp_config",
                "Labels": [],
                "Attributes": {
                    "default_recipient": "",
                    "host": "",
                    "port": "",
                    "sender": ""
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
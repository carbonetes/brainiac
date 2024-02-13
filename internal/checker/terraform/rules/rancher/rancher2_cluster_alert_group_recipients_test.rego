package lib.terraform.CB_TFRAN_105

test_rancher2_cluster_alert_group_recipients_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_group",
            "example_alert_group"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "description": "Terraform cluster alert group",
            "group_interval_seconds": "300",
            "name": "example_alert_group",
            "repeat_interval_seconds": "3600"
        },
        "Blocks": [
            {
                "Type": "recipients",
                "Labels": [],
                "Attributes": {
                    "default_recipient": false,
                    "notifier_id": "<notifier_id>",
                    "recipient": "<recipient_email_or_id>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_alert_group_recipients_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_group",
            "example_alert_group"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "description": "Terraform cluster alert group",
            "group_interval_seconds": "300",
            "name": "example_alert_group",
            "repeat_interval_seconds": "3600"
        },
        "Blocks": [
            {
                "Type": "recipients",
                "Labels": [],
                "Attributes": {
                    "default_recipient": false,
                    "notifier_id": "",
                    "recipient": "<recipient_email_or_id>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }]
    count(result) == 1
}
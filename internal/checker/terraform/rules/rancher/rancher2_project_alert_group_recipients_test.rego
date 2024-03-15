package lib.terraform.CB_TFRAN_112

test_rancher2_project_alert_group_recipients_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_group",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform project alert group",
            "group_interval_seconds": 300,
            "name": "foo",
            "project_id": "<project_id>",
            "repeat_interval_seconds": 3600
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
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_alert_group_recipients_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_group",
            "foo"
        ],
        "Attributes": {
            "description": "Terraform project alert group",
            "group_interval_seconds": 300,
            "name": "foo",
            "project_id": "<project_id>",
            "repeat_interval_seconds": 3600
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
            "endLine": 8,
            "startLine": 2
        }
    }]
    count(result) == 1
}
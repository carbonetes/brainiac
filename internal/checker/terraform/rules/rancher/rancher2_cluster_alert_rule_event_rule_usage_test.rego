package lib.terraform.CB_TFRAN_106

test_rancher2_cluster_alert_rule_event_rule_usage_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_rule",
            "example_rule"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "group_id": "<group_id>",
            "group_interval_seconds": "600",
            "name": "example_rule",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [
            {
                "Type": "event_rule",
                "Labels": [],
                "Attributes": {
                    "event_type": "Warning",
                    "resource_kind": "Pod"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            }
        ],
        "line_range": {
            "endLine": 12,
            "startLine": 1
        }
    }]
    count(result) == 1
}

test_rancher2_cluster_alert_rule_event_rule_usage_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_cluster_alert_rule",
            "example_rule"
        ],
        "Attributes": {
            "cluster_id": "<cluster_id>",
            "group_id": "<group_id>",
            "group_interval_seconds": "600",
            "name": "example_rule",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [
            {
                "Type": "event_rule",
                "Labels": [],
                "Attributes": {
                    "event_type": "Warning",
                    "resource_kind": "Pod"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 11,
                    "startLine": 8
                }
            },
            {
                "Type": "metric_rule",
                "Labels": [],
                "Attributes": {
                    "comparison": "greater-than",
                    "description": "CPU usage exceeds 70% for 5 minutes",
                    "duration": "5m",
                    "expression": "avg(cpu_usage) > 70",
                    "threshold_value": "90"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 13
                }
            },
            {
                "Type": "node_rule",
                "Labels": [],
                "Attributes": {
                    "condition": "cpu",
                    "cpu_threshold": "70",
                    "description": "CPU usage exceeds 70% and memory usage exceeds 80% on a node",
                    "mem_threshold": "80"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 26,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 27,
            "startLine": 1
        }
    }]
    count(result) == 1
}
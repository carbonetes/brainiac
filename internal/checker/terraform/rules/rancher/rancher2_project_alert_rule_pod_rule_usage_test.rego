package lib.terraform.CB_TFRAN_177

test_rancher2_project_alert_rule_pod_rule_usage_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_rule",
            "foo"
        ],
        "Attributes": {
            "group_id": "rancher2_project_alert_group.foo.id",
            "group_interval_seconds": "600",
            "name": "foo",
            "project_id": "rancher2_project_alert_group.foo.project_id",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [
            {
                "Type": "pod_rule",
                "Labels": [],
                "Attributes": {
                    "condition": "cpu",
                    "pod_id": "your_pod_id",
                    "restart_interval_seconds": "300",
                    "restart_times": "3"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 15
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_project_alert_rule_pod_rule_usage_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_project_alert_rule",
            "foo"
        ],
        "Attributes": {
            "group_id": "rancher2_project_alert_group.foo.id",
            "group_interval_seconds": "600",
            "name": "foo",
            "project_id": "rancher2_project_alert_group.foo.project_id",
            "repeat_interval_seconds": "6000"
        },
        "Blocks": [
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
                    "endLine": 14,
                    "startLine": 8
                }
            },
            {
                "Type": "pod_rule",
                "Labels": [],
                "Attributes": {
                    "condition": "cpu",
                    "pod_id": "your_pod_id",
                    "restart_interval_seconds": "300",
                    "restart_times": "3"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 15
                }
            },
            {
                "Type": "workload_rule",
                "Labels": [],
                "Attributes": {
                    "available": "70",
                    "workload_id": "your_workload_id"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 24,
                    "startLine": 21
                }
            }
        ],
        "line_range": {
            "endLine": 25,
            "startLine": 2
        }
    }]
    count(result) == 1
}
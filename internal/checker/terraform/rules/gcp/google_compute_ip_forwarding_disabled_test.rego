package lib.terraform.CB_TFGCP_077

test_google_compute_ip_forwarding_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_instance_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": false,
            "machine_type": "e2-medium",
            "metadata": {
                "serial-port-enable": false
            },
            "name": "template"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 23
        }
    }]
count(result) == 1
}

test_google_compute_ip_forwarding_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_instance_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": true,
            "machine_type": "e2-medium",
            "metadata": {
                "serial-port-enable": false
            },
            "name": "template"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 23
        }
    }]
count(result) == 1
}
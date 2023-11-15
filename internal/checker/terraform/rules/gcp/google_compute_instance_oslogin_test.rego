package lib.terraform.CB_TFGCP_071

test_google_compute_instance_oslogin_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_instance_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": true,
            "machine_type": "e2-medium",
            "metadata": {
                "13": "42",
                "fizz": "buzz",
                "enable-oslogin": true
            },
            "name": "template"
        },
        "Blocks": [
            {
                "Type": "disk",
                "Labels": [],
                "Attributes": {
                    "auto_delete": true,
                    "boot": true,
                    "disk_size_gb": "100",
                    "source_image": "debian-cloud/debian-11"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 5
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "network": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 21,
            "startLine": 1
        }
    }]
count(result) == 1
}

test_google_compute_instance_oslogin_failed {
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
                "13": "42",
                "fizz": "buzz",
                "enable-oslogin": false
            },
            "name": "template"
        },
        "Blocks": [
            {
                "Type": "disk",
                "Labels": [],
                "Attributes": {
                    "auto_delete": true,
                    "boot": true,
                    "disk_size_gb": "100",
                    "source_image": "debian-cloud/debian-11"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 10,
                    "startLine": 5
                }
            },
            {
                "Type": "network_interface",
                "Labels": [],
                "Attributes": {
                    "network": "default"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 12
                }
            }
        ],
        "line_range": {
            "endLine": 21,
            "startLine": 1
        }
    }]
count(result) == 1
}
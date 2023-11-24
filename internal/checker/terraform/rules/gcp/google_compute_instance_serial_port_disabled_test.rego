package lib.terraform.CB_TFGCP_072

test_google_compute_instance_serial_port_disabled_passed {
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
                "serial-port-enable": false
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
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 23
        }
    }]
count(result) == 1
}

test_google_compute_instance_serial_port_disabled_failed {
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
                "serial-port-enable": false
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
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_instance_from_template",
            "tpl"
        ],
        "Attributes": {
            "can_ip_forward": false,
            "labels": {
                "my_key": "my_value"
            },
            "name": "instance-from-template",
            "source_instance_template": "google_compute_instance_template.tpl.self_link_unique",
            "zone": "us-central1-a"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 34,
            "startLine": 23
        }
    }]
count(result) == 1
}
package lib.terraform.CB_TFGCP_120

test_google_compute_instance_disk_encryption_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_firewall",
            "restricted"
        ],
        "Attributes": {
            "name": "example",
            "network": "google_compute_network.vpc.name",
            "source_ranges": [
                "172.1.2.3/32"
            ],
            "target_tags": [
                "ssh"
            ]
        },
        "Blocks": [
            {
                "Type": "allow",
                "Labels": [],
                "Attributes": {
                    "ports": [
                        "90"
                    ],
                    "protocol": "tcp"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
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

test_google_compute_instance_disk_encryption_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_firewall",
            "restricted"
        ],
        "Attributes": {
            "name": "example",
            "network": "google_compute_network.vpc.name",
            "source_ranges": [
                "172.1.2.3/32"
            ],
            "target_tags": [
                "ssh"
            ]
        },
        "Blocks": [
            {
                "Type": "allow",
                "Labels": [],
                "Attributes": {
                    "ports": [
                        "80"
                    ],
                    "protocol": "tcp"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 5
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

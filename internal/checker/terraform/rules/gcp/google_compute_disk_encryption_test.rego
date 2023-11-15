package lib.terraform.CB_TFGCP_078

test_google_compute_disk_encryption_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "your-project-id",
            "region": "your-region"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_disk",
            "example_disk"
        ],
        "Attributes": {
            "name": "example-disk",
            "size": "100",
            "type": "pd-standard",
            "zone": "your-zone"
        },
        "Blocks": [
            {
                "Type": "disk_encryption_key",
                "Labels": [],
                "Attributes": {
                    "raw_key": "your-raw-key"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 16,
                    "startLine": 14
                }
            }
        ],
        "line_range": {
            "endLine": 17,
            "startLine": 7
        }
    }]
	count(result) == 1
}

test_google_compute_disk_encryption_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "your-project-id",
            "region": "your-region"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_compute_disk",
            "example_disk"
        ],
        "Attributes": {
            "name": "example-disk",
            "size": "100",
            "type": "pd-standard",
            "zone": "your-zone"
        }
    }]
	count(result) == 1
}

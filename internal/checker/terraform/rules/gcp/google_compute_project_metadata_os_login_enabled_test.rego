package lib.terraform.CB_TFGCP_070

test_google_compute_project_metadata_os_login_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_project_metadata",
            "default"
        ],
        "Attributes": {
            "metadata": {
                "13": "42",
                "fizz": "buzz",
                "oslogin": "enable-oslogin"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
count(result) == 1
}

test_google_compute_project_metadata_os_login_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_compute_project_metadata",
            "default"
        ],
        "Attributes": {
            "metadata": {
                "13": "42",
                "fizz": "buzz",
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
count(result) == 1
}
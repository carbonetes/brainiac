package lib.terraform.CB_TFGCP_070

test_google_compute_project_metadata_os_login_enabled_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<YOUR_PROJECT_ID>",
            "region": "<YOUR_REGION>"
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
            "google_compute_project_metadata",
            "example_metadata"
        ],
        "Attributes": {
            "metadata": {
                "enable-oslogin": true
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 7
        }
    }]
count(result) == 1
}

test_google_compute_project_metadata_os_login_enabled_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<YOUR_PROJECT_ID>",
            "region": "<YOUR_REGION>"
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
            "google_compute_project_metadata",
            "example_metadata"
        ],
        "Attributes": {
            "metadata": {
                "enable-oslogin": false
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 7
        }
    }]
count(result) == 1
}
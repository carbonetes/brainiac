package lib.terraform.CB_TFGCP_116

test_google_cloud_run_service_private_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_cloud_run_service_iam_binding",
            "binding"
        ],
        "Attributes": {
            "location": "google_cloud_run_service.default.location",
            "members": [
                "user:jane@example.com"
            ],
            "project": "google_cloud_run_service.default.project",
            "role": "roles/viewer",
            "service": "google_cloud_run_service.default.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_cloud_run_service_private_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_cloud_run_service_iam_binding",
            "binding"
        ],
        "Attributes": {
            "location": "google_cloud_run_service.default.location",
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "project": "google_cloud_run_service.default.project",
            "role": "roles/viewer",
            "service": "google_cloud_run_service.default.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

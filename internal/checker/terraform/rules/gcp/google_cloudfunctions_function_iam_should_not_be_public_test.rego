package lib.terraform.CB_TFGCP_121

test_google_cloudfunctions_function_iam_should_not_be_public_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_cloudfunctions_function_iam_binding",
            "binding"
        ],
        "Attributes": {
            "cloud_function": "google_cloudfunctions_function.function.name",
            "members": [
                "user:jane@example.com"
            ],
            "project": "google_cloudfunctions_function.function.project",
            "region": "google_cloudfunctions_function.function.region",
            "role": "roles/viewer"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_cloudfunctions_function_iam_should_not_be_public_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_cloudfunctions_function_iam_binding",
            "binding"
        ],
        "Attributes": {
            "cloud_function": "google_cloudfunctions_function.function.name",
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "project": "google_cloudfunctions_function.function.project",
            "region": "google_cloudfunctions_function.function.region",
            "role": "roles/viewer"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

package lib.terraform.CB_TFGCP_114

test_google_artifact_registry_repository_iam_private_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_artifact_registry_repository_iam_binding",
            "binding"
        ],
        "Attributes": {
            "location": "google_artifact_registry_repository.my-repo.location",
            "members": [
                "user:jane@example.com"
            ],
            "project": "google_artifact_registry_repository.my-repo.project",
            "repository": "google_artifact_registry_repository.my-repo.name",
            "role": "roles/artifactregistry.reader"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_artifact_registry_repository_iam_private_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_artifact_registry_repository_iam_binding",
            "binding"
        ],
        "Attributes": {
            "location": "google_artifact_registry_repository.my-repo.location",
            "members": [
                "user:jane@example.com",
                "allAuthenticatedUsers"
            ],
            "project": "google_artifact_registry_repository.my-repo.project",
            "repository": "google_artifact_registry_repository.my-repo.name",
            "role": "roles/artifactregistry.reader"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

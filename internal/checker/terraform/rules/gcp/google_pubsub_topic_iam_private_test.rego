package lib.terraform.CB_TFGCP_110

test_google_pubsub_topic_iam_private_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_pubsub_topic_iam_binding",
            "binding"
        ],
        "Attributes": {
            "members": [
                "user:jane@example.com"
            ],
            "project": "google_pubsub_topic.example.project",
            "role": "roles/viewer",
            "topic": "google_pubsub_topic.example.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_pubsub_topic_iam_private_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_pubsub_topic_iam_binding",
            "binding"
        ],
        "Attributes": {
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "project": "google_pubsub_topic.example.project",
            "role": "roles/viewer",
            "topic": "google_pubsub_topic.example.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

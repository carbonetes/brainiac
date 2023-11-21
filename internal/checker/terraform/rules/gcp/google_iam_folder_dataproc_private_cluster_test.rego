package lib.terraform.CB_TFGCP_108

test_google_iam_folder_dataproc_private_cluster_passed {
	result := passed with input as [{
        "Attributes": {
            "cluster": "your-dataproc-cluster",
            "members": [
                "user:jane@example.com"
            ],
            "role": "roles/editor"
        },
        "Blocks": [],
        "Labels": [
            "google_dataproc_cluster_iam_binding",
            "editor"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_iam_folder_dataproc_private_cluster_failed {
	result := failed with input as [{
        "Attributes": {
            "cluster": "your-dataproc-cluster",
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "role": "roles/editor"
        },
        "Blocks": [],
        "Labels": [
            "google_dataproc_cluster_iam_binding",
            "editor"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

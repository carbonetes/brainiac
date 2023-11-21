package lib.terraform.CB_TFGCP_111

test_google_bigquery_table_iam_private_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_bigquery_table_iam_binding",
            "binding"
        ],
        "Attributes": {
            "dataset_id": "google_bigquery_table.test.dataset_id",
            "members": [
                "user:jane@example.com"
            ],
            "project": "google_bigquery_table.test.project",
            "role": "roles/bigquery.dataOwner",
            "table_id": "google_bigquery_table.test.table_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_bigquery_table_iam_private_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_bigquery_table_iam_binding",
            "binding"
        ],
        "Attributes": {
            "dataset_id": "google_bigquery_table.test.dataset_id",
            "members": [
                "user:jane@example.com",
                "allUsers"
            ],
            "project": "google_bigquery_table.test.project",
            "role": "roles/bigquery.dataOwner",
            "table_id": "google_bigquery_table.test.table_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 9,
            "startLine": 1
        }
    }]
	count(result) == 1
}

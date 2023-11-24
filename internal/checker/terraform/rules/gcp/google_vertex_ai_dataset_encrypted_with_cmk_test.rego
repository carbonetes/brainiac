package lib.terraform.CB_TFGCP_096

test_google_vertex_ai_dataset_encrypted_with_cmk_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_vertex_ai_dataset",
            "dataset"
        ],
        "Attributes": {
            "display_name": "terraform",
            "labels": {
                "env": "test"
            },
            "metadata_schema_uri": "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "encryption_spec",
                "Labels": [],
                "Attributes": {
                    "kms_key_name": "projects"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 9
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

test_google_vertex_ai_dataset_encrypted_with_cmk_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_vertex_ai_dataset",
            "dataset"
        ],
        "Attributes": {
            "display_name": "terraform",
            "labels": {
                "env": "test"
            },
            "metadata_schema_uri": "gs://google-cloud-aiplatform/schema/dataset/metadata/image_1.0.0.yaml",
            "region": "us-central1"
        },
        "Blocks": [
            {
                "Type": "encryption_spec",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 12,
                    "startLine": 9
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

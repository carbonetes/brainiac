package lib.terraform.CB_TFGCP_098

test_google_dataflow_job_private_job_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "google_dataflow_job",
            "big_data_job"
        ],
        "Attributes": {
            "ip_configuration": "WORKER_IP_PRIVATE",
            "name": "dataflow-job",
            "parameters": {
                "baz": "qux",
                "foo": "bar"
            },
            "temp_gcs_location": "gs://my-bucket/tmp_dir",
            "template_gcs_path": "gs://my-bucket/templates/template_file"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_google_dataflow_job_private_job_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "google_dataflow_job",
            "big_data_job"
        ],
        "Attributes": {
            "ip_configuration": "WORKER_IP_PUBLIC",
            "name": "dataflow-job",
            "parameters": {
                "baz": "qux",
                "foo": "bar"
            },
            "temp_gcs_location": "gs://my-bucket/tmp_dir",
            "template_gcs_path": "gs://my-bucket/templates/template_file"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }]
	count(result) == 1
}

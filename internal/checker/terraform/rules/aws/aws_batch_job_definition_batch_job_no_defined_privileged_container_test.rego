package lib.terraform.CB_TFAWS_235
import rego.v1

test_aws_batch_job_definition_batch_job_no_defined_privileged_container_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_batch_job_definition",
                        "pass"
                        ],
                        "Attributes": {
                        "container_properties": "{\n    \"command\": [\"ls\", \"-la\"],\n    \"image\": \"busybox\",\n    \"memory\": 1024,\n    \"vcpus\": 1,\n    \"privileged\": false,\n    \"volumes\": [\n      {\n        \"host\": {\n          \"sourcePath\": \"/tmp\"\n        },\n        \"name\": \"tmp\"\n      }\n    ],\n    \"environment\": [\n        {\"name\": \"VARNAME\", \"value\": \"VARVAL\"}\n    ],\n    \"mountPoints\": [\n        {\n          \"sourceVolume\": \"tmp\",\n          \"containerPath\": \"/tmp\",\n          \"readOnly\": false\n        }\n    ],\n    \"ulimits\": [\n      {\n        \"hardLimit\": 1024,\n        \"name\": \"nofile\",\n        \"softLimit\": 1024\n      }\n    ]\n}\n",
                        "name": "tf_test_batch_job_definition",
                        "type": "container"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 39,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_batch_job_definition_batch_job_no_defined_privileged_container_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_batch_job_definition",
                        "pass"
                        ],
                        "Attributes": {
                        "container_properties": "{\n    \"command\": [\"ls\", \"-la\"],\n    \"image\": \"busybox\",\n    \"memory\": 1024,\n    \"vcpus\": 1,\n    \"privileged\": true,\n    \"volumes\": [\n      {\n        \"host\": {\n          \"sourcePath\": \"/tmp\"\n        },\n        \"name\": \"tmp\"\n      }\n    ],\n    \"environment\": [\n        {\"name\": \"VARNAME\", \"value\": \"VARVAL\"}\n    ],\n    \"mountPoints\": [\n        {\n          \"sourceVolume\": \"tmp\",\n          \"containerPath\": \"/tmp\",\n          \"readOnly\": false\n        }\n    ],\n    \"ulimits\": [\n      {\n        \"hardLimit\": 1024,\n        \"name\": \"nofile\",\n        \"softLimit\": 1024\n      }\n    ]\n}\n",
                        "name": "tf_test_batch_job_definition",
                        "type": "container"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 39,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}
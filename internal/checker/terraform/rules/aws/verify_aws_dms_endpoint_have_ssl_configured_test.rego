package lib.terraform.CB_TFAWS_364

import rego.v1 

test_aws_dms_endpoint_have_ssl_configured_passed if {
	result := passed with input as [
    {
        "Attributes": {
            "certificate_arn": "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012",
            "database_name": "test",
            "endpoint_id": "test-dms-endpoint-tf",
            "endpoint_type": "source",
            "engine_name": "s3",
            "extra_connection_attributes": "",
            "kms_key_arn": "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012",
            "password": "test",
            "port": "3306",
            "server_name": "test",
            "ssl_mode": "require",
            "username": "test"
        },
        "Blocks": [],
        "Labels": [
            "aws_dms_endpoint",
            "pass_source_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_aws_dms_endpoint_have_ssl_configured_failed if {
	result := failed with input as [
    {
        "Attributes": {
            "certificate_arn": "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012",
            "database_name": "test",
            "endpoint_id": "test-dms-endpoint-tf",
            "endpoint_type": "notsource",
            "engine_name": "aurora",
            "extra_connection_attributes": "",
            "kms_key_arn": "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012",
            "password": "test",
            "port": "3306",
            "server_name": "test",
            "ssl_mode": "none",
            "username": "test"
        },
        "Blocks": [],
        "Labels": [
            "aws_dms_endpoint",
            "pass_source_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 14,
            "startLine": 1
        }
    }
]
	count(result) == 1
}
package lib.terraform.CB_TFAWS_096
import rego.v1

test_verify_dms_replication_instance_publicly_accessible_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_dms_replication_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "publicly_accessible": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_dms_replication_instance_publicly_accessible_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_dms_replication_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "publicly_accessible": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}
package lib.terraform.CB_TFAWS_121
import rego.v1

test_enable_ec2_ebs_optimized_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "ebs_optimized": true
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

test_enable_ec2_ebs_optimized_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "ebs_optimized": false
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
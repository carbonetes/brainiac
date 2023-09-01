package lib.terraform.CB_TFAWS_076

test_verify_athena_workgroup_configuration_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_athena_workgroup",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "enforce_workgroup_configuration": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
                                    
    count(result) == 1
}

test_verify_athena_workgroup_configuration_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_athena_workgroup",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "enforce_workgroup_configuration": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}
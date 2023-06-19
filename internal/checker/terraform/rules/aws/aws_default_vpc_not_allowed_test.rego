package lib.terraform.CB_TFAWS_133

test_aws_default_vpc_not_allowed_passed {
    result := passed with input as [
                                    {
                                    
                                    }


                                ]
    count(result) == 1
}

test_aws_default_vpc_not_allowed_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_default_vpc",
                                    "default"
                                    ],
                                    "Attributes": {
                                    "tags": {
                                        "Name": "Default VPC"
                                    }
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

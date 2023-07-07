package lib.terraform.CB_TFAWS_186

test_aws_glue_crawler_glue_component_security_config_enabled_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_crawler",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "example",
                                    "security_configuration": "aws_glue_security_configuration.example.name"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_glue_crawler_glue_component_security_config_enabled_failed {
result := failed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_crawler",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "name": "example",
                                    "security_configuration": ""
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

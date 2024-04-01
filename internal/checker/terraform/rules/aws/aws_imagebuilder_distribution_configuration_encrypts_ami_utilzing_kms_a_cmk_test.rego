package lib.terraform.CB_TFAWS_190
import rego.v1

test_aws_imagebuilder_distribution_configuration_encrypts_ami_utilzing_kms_a_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_distribution_configuration",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "description": "non empty value",
                                    "name": "example"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "distribution",
                                        "Labels": [],
                                        "Attributes": {
                                        "region": "us-east-1"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "ami_distribution_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "ami_tags": {
                                            "CostCenter": "IT"
                                        },
                                        "kms_key_id": "aws_kms_key.fail.arn",
                                        "name": "example-{{ imagebuilder:buildDate }}"
                                        },
                                        "Blocks": [
                                        {
                                            "Type": "launch_permission",
                                            "Labels": [],
                                            "Attributes": {
                                            "user_ids": [
                                            "123456789012"
                                            ]
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                            "endLine": 16,
                                            "startLine": 14
                                            }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 6
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 20,
                                        "startLine": 5
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 21,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_imagebuilder_distribution_configuration_encrypts_ami_utilzing_kms_a_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_distribution_configuration",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "description": "non empty value",
                                    "name": "example"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "distribution",
                                        "Labels": [],
                                        "Attributes": {
                                        "region": "us-east-1"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "ami_distribution_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "ami_tags": {
                                            "CostCenter": "IT"
                                        },
                                        "kms_key_id": "",
                                        "name": "example-{{ imagebuilder:buildDate }}"
                                        },
                                        "Blocks": [
                                        {
                                            "Type": "launch_permission",
                                            "Labels": [],
                                            "Attributes": {
                                            "user_ids": [
                                            "123456789012"
                                            ]
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                            "endLine": 16,
                                            "startLine": 14
                                            }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 6
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 20,
                                        "startLine": 5
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 21,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

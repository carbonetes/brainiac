package lib.terraform.CB_TFAWS_191
import rego.v1

test_aws_imagebuilder_image_recipe_encrypted_with_cmk_test_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_image_recipe",
                                    "pass2"
                                    ],
                                    "Attributes": {
                                    "name": "example",
                                    "parent_image": "data.aws_partition.current.partition",
                                    "version": "1.0.0"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "block_device_mapping",
                                        "Labels": [],
                                        "Attributes": {
                                        "device_name": "/dev/xvdb"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "ebs",
                                        "Labels": [],
                                        "Attributes": {
                                        "delete_on_termination": true,
                                        "encrypted": true,
                                        "kms_key_id": "aws_kms_key.fail.arn",
                                        "volume_size": "100",
                                        "volume_type": "gp2"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 5
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 2
                                        }
                                    },
                                    {
                                        "Type": "component",
                                        "Labels": [],
                                        "Attributes": {
                                        "component_arn": "aws_imagebuilder_component.fail.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 16,
                                        "startLine": 14
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

test_aws_imagebuilder_image_recipe_encrypted_with_cmk_test_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_imagebuilder_image_recipe",
                                    "pass2"
                                    ],
                                    "Attributes": {
                                    "name": "example",
                                    "parent_image": "data.aws_partition.current.partition",
                                    "version": "1.0.0"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "block_device_mapping",
                                        "Labels": [],
                                        "Attributes": {
                                        "device_name": "/dev/xvdb"
                                        },
                                        "Blocks": [
                                        {
                                        "Type": "ebs",
                                        "Labels": [],
                                        "Attributes": {
                                        "delete_on_termination": true,
                                        "volume_size": "100",
                                        "volume_type": "gp2"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 5
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 2
                                        }
                                    },
                                    {
                                        "Type": "component",
                                        "Labels": [],
                                        "Attributes": {
                                        "component_arn": "aws_imagebuilder_component.fail.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 16,
                                        "startLine": 14
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

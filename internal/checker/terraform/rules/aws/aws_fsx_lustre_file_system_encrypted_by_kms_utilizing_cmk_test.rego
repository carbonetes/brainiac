package lib.terraform.CB_TFAWS_181
import rego.v1

test_aws_fsx_lustre_file_system_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_lustre_file_system",
                                    "encrypted_fs"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id",
                                    "security_group_ids": [
                                        "sg-abcdef12"
                                    ],
                                    "storage_capacity": "1200",
                                    "subnet_ids": [
                                        "subnet-12345678",
                                        "subnet-87654321"
                                    ]
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "lustre_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "deployment_type": "SCRATCH_2",
                                        "per_unit_storage_throughput": "200"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 10,
                                        "startLine": 6
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_fsx_lustre_file_system_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_lustre_file_system",
                                    "encrypted_fs"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "",
                                    "security_group_ids": [
                                        "sg-abcdef12"
                                    ],
                                    "storage_capacity": "1200",
                                    "subnet_ids": [
                                        "subnet-12345678",
                                        "subnet-87654321"
                                    ]
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "lustre_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "deployment_type": "SCRATCH_2",
                                        "per_unit_storage_throughput": "200"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 10,
                                        "startLine": 6
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

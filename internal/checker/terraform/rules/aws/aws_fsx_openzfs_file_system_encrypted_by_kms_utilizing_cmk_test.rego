package lib.terraform.CB_TFAWS_194
import rego.v1

test_aws_fsx_openzfs_file_system_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_openzfs_file_system",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "automatic_backup_retention_days": "0",
                                    "deployment_type": "var.file_system.deployment_type",
                                    "kms_key_id": "var.kms_key_id",
                                    "storage_capacity": "var.file_system.storage_capacity",
                                    "subnet_ids": "var.subnet_ids",
                                    "throughput_capacity": "var.file_system.throughput_capacity"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_fsx_openzfs_file_system_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_openzfs_file_system",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "automatic_backup_retention_days": "0",
                                    "deployment_type": "var.file_system.deployment_type",
                                    "kms_key_id": "",
                                    "storage_capacity": "var.file_system.storage_capacity",
                                    "subnet_ids": "var.subnet_ids",
                                    "throughput_capacity": "var.file_system.throughput_capacity"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 8,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

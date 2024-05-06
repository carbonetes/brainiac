package lib.terraform.CB_TFAWS_170
import rego.v1

test_aws_fsx_windows_file_system_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_windows_file_system",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "active_directory_id": "aws_directory_service_directory.example.id",
                                    "kms_key_id": "aws_kms_key.example.arn",
                                    "storage_capacity": "300",
                                    "subnet_ids": "aws_subnet.example.id",
                                    "throughput_capacity": "1024"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_fsx_windows_file_system_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_windows_file_system",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "active_directory_id": "aws_directory_service_directory.example.id",
                                    "kms_key_id": "",
                                    "storage_capacity": "300",
                                    "subnet_ids": "aws_subnet.example.id",
                                    "throughput_capacity": "1024"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

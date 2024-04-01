package lib.terraform.CB_TFAWS_169
import rego.v1

test_aws_fsx_ontap_file_system_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_ontap_file_system",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "deployment_type": "MULTI_AZ_1",
                                    "kms_key_id": "kms",
                                    "preferred_subnet_id": "aws_subnet.test1.id",
                                    "storage_capacity": "1024",
                                    "subnet_ids": "aws_subnet.test1.id",
                                    "throughput_capacity": "512"
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

test_aws_fsx_ontap_file_system_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_fsx_ontap_file_system",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "deployment_type": "MULTI_AZ_1",
                                    "kms_key_id": "",
                                    "preferred_subnet_id": "aws_subnet.test1.id",
                                    "storage_capacity": "1024",
                                    "subnet_ids": "aws_subnet.test1.id",
                                    "throughput_capacity": "512"
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

package lib.terraform.CB_TFAWS_162
import rego.v1

test_aws_qldb_ledger_deletion_protection_enabled_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_qldb_ledger",
                                "example"
                                ],
                                "Attributes": {
                                "deletion_protection": true,
                                "name": "example-ledger"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_qldb_ledger_deletion_protection_enabled_failed if {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_qldb_ledger",
                                "example"
                                ],
                                "Attributes": {
                                "deletion_protection": false,
                                "name": "example-ledger"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}
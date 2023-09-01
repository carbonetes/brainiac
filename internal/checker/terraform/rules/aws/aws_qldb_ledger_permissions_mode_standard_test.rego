package lib.terraform.CB_TFAWS_161

test_aws_qldb_ledger_permissions_mode_standard_passed{
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_qldb_ledger",
                        "standard"
                        ],
                        "Attributes": {
                        "permissions_mode": "STANDARD"
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

test_aws_qldb_ledger_permissions_mode_standard_failed {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_qldb_ledger",
                        "standard"
                        ],
                        "Attributes": {
                        "permissions_mode": "IMMUTABLE"
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
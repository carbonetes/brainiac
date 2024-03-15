package lib.cloudformation.CB_CFT_107

test_verify_qldb_deletion_enabled_pass {
    result := passed with input as {
        "Resources": {
            "MyQLDBLedger": {
                "Type": "AWS::QLDB::Ledger",
                "Properties": {
                    "DeletionProtection": true,
                }
            }
        }
    }
    count(result) == 1
}

test_verify_qldb_deletion_enabled_fail {
    result := failed with input as {
        "Resources": {
            "MyQLDBLedger": {
                "Type": "AWS::QLDB::Ledger",
                "Properties": {
                    "DeletionProtection": false,
                }
            }
        }
    }
    count(result) == 1
}

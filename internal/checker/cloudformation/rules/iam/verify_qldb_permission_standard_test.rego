package lib.cloudformation.CB_CFT_106

test_verify_qldb_ledger_permission_standard_pass {
    result := passed with input as {
        "Resources": {
            "MyQLDBLedger": {
                "Type": "AWS::QLDB::Ledger",
                "Properties": {
                    "Name": "MyLedger",
                    "PermissionsMode": "STANDARD"
                }
            }
        }
    }
    count(result) == 1
}

test_verify_qldb_ledger_permission_standard_fail {
    result := failed with input as {
        "Resources": {
            "MyQLDBLedger": {
                "Type": "AWS::QLDB::Ledger",
                "Properties": {
                    "Name": "MyLedger",
                    "PermissionsMode": "notSTANDARD"
                }
            }
        }
    }
    count(result) == 1
}


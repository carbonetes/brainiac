package lib.cloudformation.CB_CFT_077

test_documentdb_audit_logs_enabled_pass {
    result := passed with input as {
        "Resources": {
            "DocumentDBClusterParameterGroup": {
                "Type": "AWS::DocDB::DBClusterParameterGroup",
                "Properties": {
                    "Parameters": {
                        "audit_logs": true,
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_documentdb_audit_logs_enabled_fail {
    result := failed with input as {
        "Resources": {
            "DocumentDBClusterParameterGroup": {
                "Type": "AWS::DocDB::DBClusterParameterGroup",
                "Properties": {
                    "Parameters": {
                        "audit_logs": false,
                    },
                }
            }
        }
    }
    count(result) == 1
}

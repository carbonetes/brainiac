package lib.cloudformation.CB_CFT_109

test_dynamodb_globaltable_pitr_enabled_passed {
    result := passed with input as {
        "Resources": [
            {
                "Type": "AWS::DynamoDB::GlobalTable",
                "Properties": {
                    "GlobalTableName": "MyGlobalTable",
                    "Replicas": [
                        {
                            "PointInTimeRecoverySpecification": {
                                "PointInTimeRecoveryEnabled": true
                            },
                        }
                    ]
                }
            }
        ]
    }
    count(result) == 1
}

test_dynamodb_globaltable_pitr_enabled_failed {
    result := failed with input as {
        "Resources": [
            {
                "Type": "AWS::DynamoDB::GlobalTable",
                "Properties": {
                    "GlobalTableName": "MyGlobalTable",
                    "Replicas": [
                        {
                            "PointInTimeRecoverySpecification": {
                                "PointInTimeRecoveryEnabled": false
                            },
                        }
                    ]
                }
            }
        ]
    }
    count(result) == 1
}

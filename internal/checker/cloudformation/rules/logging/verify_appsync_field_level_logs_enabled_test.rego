package lib.cloudformation.CB_CFT_112

test_verify_appsync_field_logs_enabled {
    result := passed with input as {"Resources": {
        "MyAppSyncGraphQLApi": {
            "Type": "AWS::AppSync::GraphQLApi",
            "Properties": {
                "Name": "YourGraphQLApiName",
                "AuthenticationType": "API_KEY",
                "LogConfig": {
                    "FieldLogLevel": "ALL"
                }
            }
        }
    }
}
        count(result) == 1
}

test_verify_appsync_field_logs_disabled {
    result := failed with input as {
    "Resources": {
        "MyAppSyncGraphQLApi": {
            "Type": "AWS::AppSync::GraphQLApi",
            "Properties": {
                "Name": "YourGraphQLApiName",
                "AuthenticationType": "API_KEY",
                "LogConfig": {
                    "FieldLogLevel": ""
                }
            }
        }
    }
}
        count(result) == 1
}
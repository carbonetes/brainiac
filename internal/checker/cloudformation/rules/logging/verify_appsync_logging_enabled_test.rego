package lib.cloudformation.CB_CFT_111

test_verify_appsync_logging_enabled {
    result := passed with input as {"Resources": {
        "MyAppSyncGraphQLApi": {
            "Type": "AWS::AppSync::GraphQLApi",
            "Properties": {
                "Name": "YourGraphQLApiName",
                "AuthenticationType": "API_KEY",
                "LogConfig": {
                    "CloudWatchLogsRoleArn": "YourCloudWatchLogsRoleArn"
                }
            }
        }
    }
}
        count(result) == 1
}

test_verify_appsync_logging_disabled {
    result := failed with input as {"Resources": {
        "MyAppSyncGraphQLApi": {
            "Type": "AWS::AppSync::GraphQLApi",
            "Properties": {
                "Name": "YourGraphQLApiName",
                "AuthenticationType": "API_KEY",
                "LogConfig": {
                }
            }
        }
    }
}
        count(result) == 1
}
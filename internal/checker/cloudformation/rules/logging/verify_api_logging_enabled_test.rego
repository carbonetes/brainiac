package lib.cloudformation.CB_CFT_75

test_httpapi_access_log_pass {
    result := passed with input as {
        "Resources": {
            "HttpApi": {
                "Type": "AWS::Serverless::HttpApi",
                "Properties": {
                    "AccessLogSettings": {
                        "DestinationArn": "arn:aws:logs:${AWS::Region}:${AWS::AccountId}:log-group:/aws/http-api/${HttpApi}/access"
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_httpapi_access_log_fail {
    result := failed with input as {
        "Resources": {
            "HttpApi": {
                "Type": "AWS::Serverless::HttpApi",
                "Properties": {
                    "AccessLogSettings": {
                        "DestinationArn": ""
                    },
                }
            }
        }
    }
    count(result) == 1
}

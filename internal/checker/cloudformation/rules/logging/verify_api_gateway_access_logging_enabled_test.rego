package lib.cloudformation.CB_CFT_055

test_api_gateway_access_logging_enabled {
    result := passed with input as {"Resources": {
        "MyApiGatewayStage": {
            "Type": "AWS::ApiGateway::Stage",
            "Properties": {
                "RestApiId": "<YourRestApiId>",
                "StageName": "<YourStageName>",
                "DeploymentId": "<YourDeploymentId>",
                "AccessLogSetting": {
                    "DestinationArn": "<YourAccessLogDestinationArn>",
                    "Format": "<YourAccessLogFormat>"
                }
            }
        }
    }
}
        count(result) == 1
}

test_api_gateway_access_logging_disabled {
    result := failed with input as {"Resources": {
        "MyApiGatewayStage": {
            "Type": "AWS::ApiGateway::Stage",
            "Properties": {
                "RestApiId": "<YourRestApiId>",
                "StageName": "<YourStageName>",
                "DeploymentId": "<YourDeploymentId>",
                "AccessLogSetting": {
                    "Format": "<YourAccessLogFormat>"
                }
            }
        }
    }
}
        count(result) == 1
}
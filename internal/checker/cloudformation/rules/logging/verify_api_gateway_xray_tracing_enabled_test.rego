package lib.cloudformation.CB_CFT_053

test_api_gateway_stage_tracing_enabled {
    result := passed with input as {"Resources": {
    "MyApiGatewayStage": {
      "Type": "AWS::ApiGateway::Stage",
      "Properties": {
        "StageName": "<your-stage-name>",
        "TracingEnabled": true,
        "RestApiId": {
          "Ref": "MyApiGateway"
        }
      }
    }
  }
}
    count(result) == 1
}

test_api_gateway_stage_tracing_disabled  {
    result := failed with input as {"Resources": {
    "MyApiGatewayStage": {
      "Type": "AWS::ApiGateway::Stage",
      "Properties": {
        "StageName": "<your-stage-name>",
        "TracingEnabled": false,
        "RestApiId": {
          "Ref": "MyApiGateway"
        }
      }
    }
  }
}
    count(result) == 1
}

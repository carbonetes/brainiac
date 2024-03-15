package lib.cloudformation.CB_CFT_089

test_verify_api_gateway_cache_enabled {
    result := passed with input as {"Resources": {
    "MyApiGatewayStage": {
      "Type": "AWS::ApiGateway::Stage",
      "Properties": {
        "RestApiId": "your-rest-api-id",
        "StageName": "your-stage-name",
        "CacheClusterEnabled": true
      }
    }
  }
}
    count(result) == 1
}

test_verify_api_gateway_cache_disabled {
    result := failed with input as {"Resources": {
    "MyApiGatewayStage": {
      "Type": "AWS::ApiGateway::Stage",
      "Properties": {
        "RestApiId": "your-rest-api-id",
        "StageName": "your-stage-name",
        "CacheClusterEnabled": false
      }
    }
  }
}
    count(result) == 1
}
package lib.cloudformation.CB_CFT_041

test_verify_no_access_backend_api_pass {
    result := passed with input as {
        "Resources": {
            "MyApiGatewayMethod": {
                "Type": "AWS::ApiGateway::Method",
                "Properties": {
                    "ApiKeyRequired": true,
                    "AuthorizationType": "NONE",
                    "HttpMethod": "GET",
    }}}}
    count(result) == 1
}

test_verify_no_access_backend_api_fail {
    result := failed with input as {
          "Resources": {
            "MyApiGatewayMethod": {
                "Type": "AWS::ApiGateway::Method",
                "Properties": {
                    "ApiKeyRequired": false,
                    "AuthorizationType": "NONE",
                    "HttpMethod": "OPTIONS",
    }}}}
    count(result) == 1
}
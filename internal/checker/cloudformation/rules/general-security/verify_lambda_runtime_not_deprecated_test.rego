package lib.cloudformation.CB_CFT_120

test_verify_lambda_runtime_not_deprecated_pass {
    result := passed with input as {
        "Resources": {
            "MyServerlessFunction": {
                "Type": "AWS::Lambda::Function",
                "Properties": {
                    "Runtime": "sample version",
                }
            }
        }
    }
    count(result) == 1
}

test_verify_lambda_runtime_not_deprecated_fail {
    result := failed with input as {
        "Resources": {
            "MyServerlessFunction": {
                "Type": "AWS::Lambda::Function",
                "Properties": {
                    "Runtime": "nodejs4.3-edge",
                }
            }
        }
    }
    count(result) == 1
}

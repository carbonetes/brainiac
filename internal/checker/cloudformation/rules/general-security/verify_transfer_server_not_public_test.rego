package lib.cloudformation.CB_CFT_103

test_verify_transfer_server_not_public_pass {
    result := passed with input as {
        "Resources": {
            "TransferServer": {
                "Type": "AWS::Transfer::Server",
                "Properties": {
                    "EndpointType": "VPC",
                }
            }
        }
    }
    count(result) == 1
}

test_verify_transfer_server_not_public_fail {
    result := failed with input as {
          "Resources": {
            "TransferServer": {
                "Type": "AWS::Transfer::Server",
                "Properties": {
                    "EndpointType": "notVPC",
                }
            }
        }
    }
    count(result) == 1
}

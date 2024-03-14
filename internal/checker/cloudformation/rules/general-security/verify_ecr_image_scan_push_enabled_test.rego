package lib.cloudformation.CB_CFT_102

test_verify_ecr_image_scan_push_enabled_pass {
    result := passed with input as {
        "Resources": {
            "MyECRRepository": {
                "Type": "AWS::ECR::Repository",
                "Properties": {
                    "ImageScanningConfiguration": {
                        "scanOnPush": true
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_verify_ecr_image_scan_push_enabled_fail {
    result := failed with input as {
        "Resources": {
            "MyECRRepository": {
                "Type": "AWS::ECR::Repository",
                "Properties": {
                    "ImageScanningConfiguration": {
                        "scanOnPush": false
                    },
                }
            }
        }
    }
    count(result) == 1
}

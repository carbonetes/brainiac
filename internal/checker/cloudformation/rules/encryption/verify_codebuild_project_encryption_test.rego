package lib.cloudformation.CB_CFT_056

test_verify_codebuild_project_with_encryption {
    result := passed with input as {"Resources": {
        "MyCodeBuildProject": {
            "Type": "AWS::CodeBuild::Project",
            "Properties": {
                "Artifacts": {
                    "Type": "S3",
                    "EncryptionDisabled": false
                }
            }
        }
    }}
    count(result) == 1
}

test_verify_codebuild_project_without_encryption {
    result := failed with input as {"Resources": {
        "MyCodeBuildProject": {
            "Type": "AWS::CodeBuild::Project",
            "Properties": {
                "Artifacts": {
                    "Type": "S3",
                    "EncryptionDisabled": true
                }
            }
        }
    }}
    count(result) == 1
}
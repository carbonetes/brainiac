package lib.cloudformation.CB_CFT_073

test_glue_security_configuration_pass {
    result := passed with input as {
        "Resources": {
            "GlueSecurityConfiguration": {
                "Type": "AWS::Glue::SecurityConfiguration",
                "Properties": {
                    "EncryptionConfiguration": {
                        "CloudWatchEncryption": {
                            "CloudWatchEncryptionMode": "SSE-KMS",                         
                        },
                        "JobBookmarksEncryption": {
                            "JobBookmarksEncryptionMode": "SSE-KMS",
                        },
                        "S3Encryption": {
                            "S3EncryptionMode": "SSE-S3"
                        }
                    }
                }
            }
        }
    }
    count(result) == 1
}

test_glue_security_configuration_fail {
    result := failed with input as {
        "Resources": {
            "GlueSecurityConfiguration": {
                "Type": "AWS::Glue::SecurityConfiguration",
                "Properties": {
                    "EncryptionConfiguration": {
                        "CloudWatchEncryption": {
                            "CloudWatchEncryptionMode": "DISABLED",
                        },
                        "JobBookmarksEncryption": {
                            "JobBookmarksEncryptionMode": "DISABLED",
                        },
                        "S3Encryption": {
                            "S3EncryptionMode": "DISABLED"
                        }
                    }
                }
            }
        }
    }
    count(result) == 1
}

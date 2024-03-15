package lib.cloudformation.CB_CFT_113

test_verify_glue_component_security_configuration_exist {
    result := passed with input as {"Resources": {
        "MyGlueCrawler": {
            "Type": "AWS::Glue::Crawler",
            "Properties": {
                "DatabaseName": "YourDatabaseName",
                "Targets": {
                    "S3Targets": [
                        {
                            "Path": "s3://your-s3-bucket/path/to/data"
                        }
                    ]
                },
                "SecurityConfiguration": "YourSecurityConfigurationName"
            }
        }
    }
}
        count(result) == 1
}

test_verify_glue_component_security_configuration_not_exist {
    result := failed with input as {"Resources": {
        "MyGlueCrawler": {
            "Type": "AWS::Glue::Crawler",
            "Properties": {
                "DatabaseName": "YourDatabaseName",
                "Targets": {
                    "S3Targets": [
                        {
                            "Path": "s3://your-s3-bucket/path/to/data"
                        }
                    ]
                },
            }
        }
    }
}
        count(result) == 1
}
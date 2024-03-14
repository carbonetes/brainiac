package lib.cloudformation.CB_CFT_078

test_redshift_use_ssl_pass {
    result := passed with input as {
        "Resources": {
            "RedshiftClusterParameterGroup": {
                "Type": "AWS::Redshift::ClusterParameterGroup",
                "Properties": {
                    "Parameters": [
                        {
                            "ParameterName": "require_ssl",
                            "ParameterValue": true,
                        }
                    ],
                }
            }
        }
    }
    count(result) == 1
}

test_redshift_use_ssl_fail {
    result := failed with input as {
        "Resources": {
            "RedshiftClusterParameterGroup": {
                "Type": "AWS::Redshift::ClusterParameterGroup",
                "Properties": {
                    "Parameters": [
                        {
                            "ParameterName": "not_require_ssl",
                            "ParameterValue": false,
                        }
                    ],
                }
            }
        }
    }
    count(result) == 1
}

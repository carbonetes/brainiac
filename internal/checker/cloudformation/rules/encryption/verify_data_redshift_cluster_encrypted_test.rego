package lib.cloudformation.CB_CFT_046

test_verify_redshift_cluster_encryption_pass {
    result := passed with input as {
        "Resources": {
            "RedshiftCluster": {
                "Type": "AWS::Redshift::Cluster",
                "Properties": {
                    "Encrypted": true,
                }
            }
        }
    }
    count(result) == 1
}

test_verify_redshift_cluster_encryption_fail {
    result := failed with input as {
       "Resources": {
            "RedshiftCluster": {
                "Type": "AWS::Redshift::Cluster",
                "Properties": {
                    "Encrypted": false,
                }
            }
        }
    }
    count(result) == 1
}

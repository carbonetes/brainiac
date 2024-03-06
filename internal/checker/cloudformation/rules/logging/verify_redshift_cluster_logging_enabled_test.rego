package lib.cloudformation.CB_CFT_057

test_redshift_cluster_logging_is_enabled {
    result := passed with input as {"Resources": {
    "MyRedshiftCluster": {
      "Type": "AWS::Redshift::Cluster",
      "Properties": {
        "ClusterType": "multi-node",
        "NumberOfNodes": 2,
        "MasterUsername": "admin",
        "MasterUserPassword": "admin",
        "ClusterIdentifier": "MyRedshiftCluster",
        "LoggingProperties": {
          "BucketName": "your-s3-bucket-for-logs",
          "S3KeyPrefix": "hello"
        }
      }
    }
  }
}
    count(result) == 1
}

test_redshift_cluster_logging_is_disabled  {
    result := failed with input as {"Resources": {
    "MyRedshiftCluster": {
      "Type": "AWS::Redshift::Cluster",
      "Properties": {
        "ClusterType": "multi-node",
        "NumberOfNodes": 2,
        "MasterUsername": "admin",
        "MasterUserPassword": "admin",
        "ClusterIdentifier": "MyRedshiftCluster",
        "LoggingProperties": {
        }
      }
    }
  }
}
    count(result) == 1
}

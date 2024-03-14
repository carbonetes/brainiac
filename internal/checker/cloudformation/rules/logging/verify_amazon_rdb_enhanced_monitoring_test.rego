package lib.cloudformation.CB_CFT_087

test_aws_rdb_enhanced_monitoring_enhanced {
	result := passed with input as {"Resources": {
    "MyDBInstance": {
      "Type": "AWS::RDS::DBInstance",
      "Properties": {
        "Engine": "mysql",
        "DBInstanceIdentifier": "mydbinstance",
        "MasterUsername": "admin",
        "MasterUserPassword": "password",
        "AllocatedStorage": "20",
        "DBInstanceClass": "db.t2.micro",
        "EngineVersion": "5.7",
        "MonitoringInterval": 1
      }
    }
  }
}
	count(result) == 1
}

test_aws_rdb_enhanced_monitoring_not_enhanced {
	result := failed with input as {"Resources": {
    "MyDBInstance": {
      "Type": "AWS::RDS::DBInstance",
      "Properties": {
        "Engine": "mysql",
        "DBInstanceIdentifier": "mydbinstance",
        "MasterUsername": "admin",
        "MasterUserPassword": "password",
        "AllocatedStorage": "20",
        "DBInstanceClass": "db.t2.micro",
        "EngineVersion": "5.7",
        "MonitoringInterval": 100
      }
    }
  }
}
	 count(result) == 1
}
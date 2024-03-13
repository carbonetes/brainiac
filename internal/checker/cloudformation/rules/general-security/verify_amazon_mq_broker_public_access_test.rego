package lib.cloudformation.CB_CFT_051

test_amazon_mq_broker_disabled_public_access {
	result := passed with input as {"Resources": {
    "MyMQBroker": {
      "Type": "AWS::AmazonMQ::Broker",
      "Properties": {
        "BrokerName": "MyMQBroker",
        "EngineType": "ACTIVEMQ",
        "EngineVersion": "5.15.8",
        "HostInstanceType": "mq.t2.micro",
        "Users": [
          {
            "ConsoleAccess": false,
            "Groups": ["group1"],
            "Password": "MyPassword",
            "Username": "MyUser"
          }
        ],
        "PubliclyAccessible": false,
        "SecurityGroups": ["sg-0123456789abcdef0"],
        "SubnetIds": [
          "subnet-0123456789abcdef0",
          "subnet-0123456789abcdef1"
        ],
        "Configuration": {
          "Id": "ActiveMQ",
          "EngineVersion": "5.15.8"
        }
      }
    }
  }
}
	count(result) == 1
}

test_amazon_mq_broker_enabled_public_access {
	result := passed with input as {"Resources": {
    "MyMQBroker": {
      "Type": "AWS::AmazonMQ::Broker",
      "Properties": {
        "BrokerName": "MyMQBroker",
        "EngineType": "ACTIVEMQ",
        "EngineVersion": "5.15.8",
        "HostInstanceType": "mq.t2.micro",
        "Users": [
          {
            "ConsoleAccess": false,
            "Groups": ["group1"],
            "Password": "MyPassword",
            "Username": "MyUser"
          }
        ],
        "PubliclyAccessible": true,
        "SecurityGroups": ["sg-0123456789abcdef0"],
        "SubnetIds": [
          "subnet-0123456789abcdef0",
          "subnet-0123456789abcdef1"
        ],
        "Configuration": {
          "Id": "ActiveMQ",
          "EngineVersion": "5.15.8"
        }
      }
    }
  }
}
	count(result) == 0
}

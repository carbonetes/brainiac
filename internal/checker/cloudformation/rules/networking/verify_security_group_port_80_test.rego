package lib.cloudformation.CB_CFT_116

test_verify_security_group_port_80_allowed {
    result := passed with input as {"Resources": {
    "MySecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "My Security Group",
        "SecurityGroupIngress": [
          {
            "Description": "Allow incoming HTTP traffic",
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIp": "10.0.0.0/0"
          },
        ],
        "SecurityGroupEgress": [
          {
            "Description": "Allow outgoing HTTP traffic",
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIp": "10.0.0.0/0"
          }
        ]
      }
    }
  }
}
        count(result) == 1
}

test_verify_security_group_port_80_not_allowed {
    result := failed with input as {"Resources": {
    "MySecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "My Security Group",
        "SecurityGroupIngress": [
          {
            "Description": "Allow incoming HTTP traffic",
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIp": "0.0.0.0/0"
          },
        ],
        "SecurityGroupEgress": [
          {
            "Description": "Allow outgoing HTTP traffic",
            "IpProtocol": "tcp",
            "FromPort": 80,
            "ToPort": 80,
            "CidrIp": "0.0.0.0/0"
          }
        ]
      }
    }
  }
}
        count(result) == 1
}
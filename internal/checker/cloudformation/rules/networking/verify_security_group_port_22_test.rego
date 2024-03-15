package lib.cloudformation.CB_CFT_014

test_verify_security_group_port_22_allowed {
    result := passed with input as {"Resources": {
    "MySecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "My Security Group",
        "SecurityGroupIngress": [
          {
            "Description": "Allow incoming HTTP traffic",
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIp": "10.0.0.0/0"
          },
          {
            "Description": "Allow incoming RDP traffic",
            "IpProtocol": "tcp",
            "FromPort": 3389,
            "ToPort": 3389,
            "CidrIp": "10.0.0.0/0"
          }
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

test_verify_security_group_port_22_not_allowed {
    result := failed with input as {"Resources": {
    "MySecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "My Security Group",
        "SecurityGroupIngress": [
          {
            "Description": "Allow incoming SSH traffic",
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIp": "0.0.0.0/0"
          },
          {
            "Description": "Allow incoming RDP traffic",
            "IpProtocol": "tcp",
            "FromPort": 3389,
            "ToPort": 3389,
            "CidrIp": "0.0.0.0/0"
          }
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
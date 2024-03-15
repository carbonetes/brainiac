package lib.cloudformation.CB_CFT_074

test_verify_eks_node_no_implicit_ssh_pass {
    result := passed with input as {
        "Resources": {
            "MyNodeGroup": {
                "Type": "AWS::EKS::Nodegroup",
                "Properties": {
                    "ClusterName": "YourEKSCLusterName",
                    "NodeRole": "NodeInstanceRole.Arn",
                    "RemoteAccess": {
                        "Ec2SshKey": "my-ssh-key",
                        "SourceSecurityGroups": [
                            "sg-12345678"
                        ]
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_verify_eks_node_no_implicit_ssh_fail {
    result := failed with input as {
        "Resources": {
            "MyNodeGroup": {
                "Type": "AWS::EKS::Nodegroup",
                "Properties": {
                    "ClusterName": "YourEKSCLusterName",
                    "NodeRole": "NodeInstanceRole.Arn",
                    "RemoteAccess": {
                        "Ec2SshKey": "0.0.0.0/0",
                    },
                }
            }
        }
    }
    count(result) == 1
}

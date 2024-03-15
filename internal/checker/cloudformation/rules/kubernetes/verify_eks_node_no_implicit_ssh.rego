# METADATA
# title: "Verify EKS node group no implicit SSH access from 0.0.0.0/0"
# description: "This policy ensures that your AWS EKS node group doesn't permit SSH access from 0.0.0.0/0. This prevents unauthorized internet-based connections, bolstering the security of your node group."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-eks-nodegroup.html
# custom:
#   id: CB_CFT_074
#   severity: HIGH
package lib.cloudformation.CB_CFT_074
import future.keywords.in

resource := "AWS::EKS::Nodegroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    remote := properties.RemoteAccess
    "Ec2SshKey" in object.keys(remote)
    "SourceSecurityGroups" in object.keys(remote)
    remote.Ec2SshKey != "0.0.0.0/0"
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AWS EKS node group does not have implicit SSH access from 0.0.0.0/0",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AWS EKS node group does have implicit SSH access from 0.0.0.0/0",
		"snippet": block,
	}
}

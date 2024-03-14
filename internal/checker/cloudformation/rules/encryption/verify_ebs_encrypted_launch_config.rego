# METADATA
# title: "Verify all data stored in EBS instances is properly encrypted"
# description: "This policy outlines the setup of an Auto Scaling group responsible for configuring Amazon EC2 instances, particularly focusing on those utilizing Elastic Block Store (EBS). It emphasizes the importance of verifying that all data stored within the launch configurations for EBS instances is adequately encrypted to maintain security standards. Furthermore, it recommends utilizing the UpdatePolicy attribute, along with provided sample policies, to ensure that updates to the configuration affect existing instances while preserving their integrity."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-autoscaling-launchconfiguration.html
# custom:
#   id: CB_CFT_006
#   severity: HIGH
package lib.cloudformation.CB_CFT_006

import future.keywords.in

resource := "AWS::AutoScaling::LaunchConfiguration"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[resources] {
	is_valid
	resources := input.Resources
	count(fail) == 0
}

fail[resources] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    some block in resources.Properties.BlockDeviceMappings
    block.Ebs.Encrypted = false
}

passed[result] {
    some block in pass
    result := {
        "message": "All data stored in launch configurations for EBS instances is securely encrypted.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "All data stored in launch configurations for EBS instances needs to be encrypted",
        "snippet": block,
    }
}

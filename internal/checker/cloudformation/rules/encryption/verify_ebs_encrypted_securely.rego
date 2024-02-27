# METADATA
# title: "Verify that all information stored in the EBS is encrypted securely."
# description: "This policy ensures that all Elastic Block Store (EBS) volumes defined in the CloudFormation template have encryption enabled. It verifies that the 'Encrypted' property is set to 'true' for each EBS volume resource. This helps enforce security best practices to protect sensitive data stored within AWS EBS volumes."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volume.html
# custom:
#   id: CB_CFT_002
#   severity: HIGH
package lib.cloudformation.CB_CFT_002
import future.keywords.in

resource := "AWS::EC2::Volume"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	resources := input.Resources
	is_valid
	properties := resources.Properties
	is_encrypted := true
	properties.Encrypted == is_encrypted
}

pass[block] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    block :=  resources.Properties.Encrypted
	block = true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some block in pass
 	result := {
		"message": "Encryption settings are enforced for the EBS volume.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption settings must be  enforced for the EBS volume.",
		"snippet": block,
	}
}
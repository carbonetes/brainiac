# METADATA
# title: "Verify that encryption for data is enabled for EFS."
# description: "This Policy ensures that Amazon EFS, a scalable file storage solution for AWS and on-premises resources, automatically adjusts its size as files are added or removed. Encrypting Amazon EFS data and metadata is essential to prevent unauthorized access and comply with data-at-rest encryption requirements in production systems."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-volume.html
# custom:
#   id: CB_CFT_32
#   severity: HIGH
package lib.cloudformation.CB_CFT_32
import future.keywords.in

resource := "AWS::EFS::FileSystem"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties
	properties.Encrypted == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "EFS is encrypted",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "EFS should be encrypted",
		"snippet": block,
	}
}

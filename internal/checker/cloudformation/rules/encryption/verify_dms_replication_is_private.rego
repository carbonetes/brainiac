# METADATA
# title: "Verify DMS replication is private."
# description: "This policy pertains to the AWS Database Migration Service (AWS DMS), which facilitates the migration of various data storage systems. AWS DMS can migrate data to and from the AWS Cloud, on-premises instances, and hybrid environments. Replication instances in AWS DMS can have both public and private IP addresses, similar to Amazon EC2 instances. Disabling the Publicly accessible option results in the replication instance having only a private IP address."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationinstance.html
# custom:
#   id: CB_CFT_065
#   severity: HIGH
package lib.cloudformation.CB_CFT_065
import future.keywords.in

resource := "AWS::DMS::ReplicationInstance"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource 	
	block := resources.Properties
	block.PubliclyAccessible == false
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DMS replication is private.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DMS replication is not private",
		"snippet": block,
	}
}

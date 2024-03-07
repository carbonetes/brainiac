# METADATA
# title: "Verify DMS replication is private."
# description: "Ensuring the Privacy of AWS Database Migration Service (DMS) Replication Instances: A Verification Process to Confirm Non-Public Accessibility."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationinstance.html
# custom:
#   ID: CB_CFT_070
#   Severity: HIGH
package lib.cloudformation.CB_CFT_070
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

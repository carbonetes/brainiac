# METADATA
# title: "Verify DocumentDB TLS is enabled."
# description: "Conducting Verification: Ensuring that Amazon DocumentDB TLS is Enabled for Secure Data Communication."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html
# custom:
#   id: CB_CFT_071
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_071
import future.keywords.in

resource := "AWS::DocDB::DBClusterParameterGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.Parameters
	block.tls == "enabled"
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DocumentDB TLS is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DocumentDB TLS is disabled.",
		"snippet": block,
	}
}

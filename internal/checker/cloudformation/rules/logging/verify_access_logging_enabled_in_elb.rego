# METADATA
# title: "Verify access logging enabled in ELB"
# description: "This policy enables analysis of traffic patterns and troubleshooting of security and operational issues. Access logging, optional in ELB, is disabled by default."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancing-loadbalancer.html
# custom:
#   id: CB_CFT_068
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_068
import future.keywords.in

resource := "AWS::ElasticLoadBalancing::LoadBalancer"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties.AccessLoggingPolicy
	block.Enabled == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ELB access logging is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ELB access logging is disabled",
		"snippet": block,
	}
}

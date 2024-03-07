# METADATA
# title: "Verify access logging enabled in ELB"
# description: "Ensure that access logging is enabled for an Elastic Load Balancer (ELB) by verifying the appropriate settings in the configuration."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancing-loadbalancer.html
# custom:
#   id: CB_CFT_073
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_073
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

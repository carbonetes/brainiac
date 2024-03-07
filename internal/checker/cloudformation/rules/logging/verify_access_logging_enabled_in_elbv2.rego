# METADATA
# title: "Verify access logging enabled in ELBv2"
# description: "Verification Process: Ensuring Access Logging is Enabled for an Amazon Elastic Load Balancer (ELBv2) to Monitor and Record Traffic Activity for Enhanced Visibility and Analysis."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html
# custom:
#   id: CB_CFT_072
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_072
import future.keywords.in

resource := "AWS::ElasticLoadBalancingV2::LoadBalancer"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.LoadBalancerAttributes
	some value in block.Value
    value == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Access loggin is enabled in ELBv2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Access loggin is disabled in ELBv2.",
		"snippet": block,
	}
}

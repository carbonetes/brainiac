# METADATA
# title: "Verify access logging enabled in ELBv2"
# description: "This policy enables ELBv2 access logs, capturing TLS request details for NLBs. Access logging, an optional feature, incurs no additional charges beyond standard Amazon S3 storage costs. Once enabled, ELBv2 compresses and stores logs in the specified S3 bucket."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide aws-resource-elasticloadbalancingv2-loadbalancer.html
# custom:
#   id: CB_CFT_067
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_067
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
	block := resources.Properties
    some value in block.LoadBalancerAttributes
	value.Value == true
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

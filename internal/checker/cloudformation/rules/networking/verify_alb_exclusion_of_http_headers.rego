# METADATA
# title: "Verify the ALB's Exclusion of HTTP Headers"
# description: "This policy advises enabling the Drop Invalid Header Fields feature for Amazon Application Load Balancers (ALBs). It ensures that invalid HTTP headers are removed by the ALB instead of being sent to associated targets, enhancing security and compliance."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html
# custom:
#   id: CB_CFT_091
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_091
import future.keywords.in

resource := "AWS::ElasticLoadBalancingV2::LoadBalancer"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
    properties := resources.Properties
    some key_value in properties.LoadBalancerAttributes
    key_value.Key == "routing.http.drop_invalid_header_fields.enabled"
    some value in properties.LoadBalancerAttributes
    value.Value == "true"
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "ALB drops HTTP headers",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "ALB should drop HTTP headers",
		"snippet": properties,
	}
}

# METADATA
# title: "Verify Load Balancer Listener using at least TLS v1.2"
# description: "This policy defines a listener within an AWS Load Balancer, responsible for monitoring connection requests. Users can designate a listener during load balancer creation or add one later. The HTTPS listener ensures traffic encryption between the load balancer and clients initiating SSL or TLS sessions."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html
# custom:
#   id: CB_CFT_076
#   severity: HIGH
package lib.cloudformation.CB_CFT_076
import future.keywords.in

resource := "AWS::ElasticLoadBalancingV2::Listener"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    protocol_value := ["HTTPS", "TCP", "UDP", "TCP_UDP"]
	properties.Protocol in protocol_value
    "SslPolicy" in object.keys(properties)
    http_policy := ["ELBSecurityPolicy-FS-1-2", "ELBSecurityPolicy-TLS-1-2", "ELBSecurityPolicy-TLS13-1-2", "ELBSecurityPolicy-TLS13-1-3"]
    properties.SslPolicy in http_policy
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    protocol_value := ["TLS", "TCP", "UDP", "TCP_UDP"]
	properties.Protocol in protocol_value
    "SslPolicy" in object.keys(properties)
    tls_policy := ["ELBSecurityPolicy-TLS13-1-3-2021-06", "ELBSecurityPolicy-TLS13-1-2", "ELBSecurityPolicy-FS-1-2", "ELBSecurityPolicy-TLS-1-2"]
    properties.SslPolicy in tls_policy
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Load Balancer Listener is using atleast TLS v1.2",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Load Balancer Listener is not using atleast TLS v1.2",
		"snippet": block,
	}
}

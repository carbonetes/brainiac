# METADATA
# title: "Verify ALB protocol is HTTPS"
# description: "This policy exposes an AWS ELB/ALB to the internet, providing a publicly accessible DNS name for accepting HTTP(S) requests. However, without HTTPS listeners, it opens vulnerabilities to man-in-the-middle attacks and traffic interception between web clients and the load balancer."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html
# custom:
#   id: CB_CFT_001
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_001
import future.keywords.in

resource := "AWS::ElasticLoadBalancingV2::Listener"

is_valid{
	some resources in input.Resources
    resources.Type == resource
}

pass[properties]{
	resources := input.Resources
    is_valid
    properties := resources.ListenerHTTPS.Properties
    valid_protocol := ["HTTPS", "TLS", "TCP", "UDP", "TCP_UDP"]
    properties.Protocol in valid_protocol
}

pass[block]{
    is_valid
    some resources in input.Resources
    default_action := resources.Properties.DefaultActions
    some block in default_action
    block.Type == "redirect"
    block.RedirectConfig.Protocol == "HTTPS"
}

fail[resources]{
	resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := { "message": "ALB protocol is HTTPS.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "ALB protocol should be set to HTTPS.",
                "snippet": block }
} 






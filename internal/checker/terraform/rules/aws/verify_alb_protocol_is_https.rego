# METADATA
# title: "Verify ALB protocol is HTTPS"
# description: "Using plain HTTP for communication between the client and the load balancer means that the traffic is not encrypted, making it vulnerable to interception and eavesdropping."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFAWS_002
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_002

import future.keywords.in 

supportedResource := ["aws_alb_listener", "aws_lb_listener"]
seccuredProtocol := ["HTTPS", "TLS", "TCP", "UDP" ,"TCP_UDP"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := failedChecks[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.protocol == seccuredProtocol[_]
}

failedChecks[block] {
    block := input[_]
	isvalid(block)
    passed := pass
    count(passed) == 0
}

passed[result] {
	block := pass[_]
	result := { "message": "The ALB protocol should is set properly.",
                "snippet": block}
}

failed[result] {
    block := failedChecks[_]
	result := { "message": "The ALB protocol should is set to secure.",
                "snippet": block }
}
# METADATA
# title: "Verify that the load balancer is utilizing at least TLS 1.2"
# description: "Between your load balancer and the clients who start SSL or TLS sessions, the HTTPS listener provides traffic encryption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/elasticloadbalancing/latest/network/create-tls-listener.html
# custom:
#   id: CB_TFAWS_065
#   severity: HIGH
package lib.terraform.CB_TFAWS_065

import future.keywords.in 

supportedResource := ["aws_lb", "aws_lb_listener", "aws_alb_listener"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[block] {
  protocolCheck := ["TCP", "UDP", "TCP_UDP"]
  block := input[_]
  isvalid(block)
  block.Attributes.protocol == protocolCheck[_]
}

pass[block] {
  protocolCheck := ["HTTPS", "TLS"]
  sslPolicyCheck := ["ELBSecurityPolicy-FS-1-2", "ELBSecurityPolicy-TLS-1-2", "ELBSecurityPolicy-TLS13"]
  block := input[_]
  isvalid(block)
  block.Attributes.protocol == protocolCheck[_]
  sslPolicy := block.Attributes.ssl_policy
  startswith(sslPolicy, sslPolicyCheck[_])
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "TLS 1.2 is being utilized by load balancer.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "TLS 1.2 should be utilized by load balancer.",
                "snippet": block}
}

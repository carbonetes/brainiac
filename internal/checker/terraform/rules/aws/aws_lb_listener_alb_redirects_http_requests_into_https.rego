# METADATA
# title: "See to it that ALB shifts HTTP requests to HTTPS requests"
# description: "Verify that the load balancer reroutes any traffic coming from the encrypted endpoint instead of performing it over http or no reactivity at all."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
# custom:
#   id: CB_TFAWS_366
#   severity: LOW
package lib.terraform.CB_TFAWS_366

supportedResources := ["aws_alb", "aws_lb"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelForAlb[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == supportedResources[_]
    label := concat(".", resource.Labels)
}

hasInvalidListenerConnections{
    resource := input[_]
    resource.Type == "resource"
    validListener := ["aws_alb_listener", "aws_lb_listener"]
    resource.Labels[_] == validListener[_]
    contains(resource.Attributes.load_balancer_arn, getTheLabelForAlb[_])
    resource.Attributes.port == "80"
   	resource.Attributes.protocol == "HTTP"
    not hasValidDefaultAction(resource)
}

hasValidDefaultAction(resource) {
   block := resource.Blocks[_]
   block.Type == "default_action"
   block.Attributes.type == "redirect"
   innerBlock := block.Blocks[_]
   innerBlock.Type == "redirect"
   innerBlock.Attributes.port == "443"
   innerBlock.Attributes.protocol == "HTTPS"
   
}

fail[resource] {
    resource := input[_]
    isvalid(resource)
    hasInvalidListenerConnections
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}




passed[result] {
	block := pass[_]
	result := { "message": "The ALB shifts HTTP requests to HTTPS requests.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The ALB must shift HTTP requests to HTTPS requests.",
                "snippet": block }
} 
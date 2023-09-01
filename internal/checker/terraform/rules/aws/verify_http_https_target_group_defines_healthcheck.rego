# METADATA
# title: "Verify HTTP HTTPS Target group defines Healthcheck"
# description: "This verification helps maintain the reliability and availability of the target instances by automatically removing unhealthy instances from the load balancer's routing pool."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.43.0/docs/resources/lb_target_group
# custom:
#   id: CB_TFAWS_254
#   severity: LOW
package lib.terraform.CB_TFAWS_254

supportedResources := ["aws_alb_target_group", "aws_lb_target_groupaws_lb_target_group"]

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

pass[block]{
    block := input[_]
    isvalid(block)
    protocols := ["HTTP", "HTTPS"]
    block.Attributes.protocol == protocols[_]
    block.Blocks[_].Type == "health_check"
    block.Blocks[_].Attributes.path != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "HTTP HTTPS Target group defines Healthcheck.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "HTTP HTTPS Target group Healthcheck must be define",
                "snippet": block}
}

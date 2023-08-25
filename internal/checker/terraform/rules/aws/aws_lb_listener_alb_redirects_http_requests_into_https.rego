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

supportedResources := ["aws_lb_listener", "aws_alb_listener"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsLb[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_lb"
    label := concat(".", resource.Labels)
}

getTheLabelforAwsAlb[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_alb"
    label := concat(".", resource.Labels)
}

isValidResourceAttachedForAwsLb{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_lb_listener"
    resource.Attributes.port == "80"
    resource.Attributes.protocol == "HTTP"
    resource.Blocks[_].Type == "default_action"
    resource.Blocks[_].Attributes.type == "redirect"
    resource.Blocks[_].Blocks[_].Type == "redirect"
    resource.Blocks[_].Blocks[_].Attributes.port == "443"
    resource.Blocks[_].Blocks[_].Attributes.protocol == "HTTPS"

}

isValidResourceAttachedForAwsAlb{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_alb_listener"
    resource.Attributes.port == "80"
    resource.Attributes.protocol == "HTTP"
    resource.Blocks[_].Type == "default_action"
    resource.Blocks[_].Attributes.type == "redirect"
    resource.Blocks[_].Blocks[_].Type == "redirect"
    resource.Blocks[_].Blocks[_].Attributes.port == "443"
    resource.Blocks[_].Blocks[_].Attributes.protocol == "HTTPS"

}

pass[resource]{
    resource := input[_]
    isValidResourceAttachedForAwsLb
    contains(resource.Attributes.load_balancer_arn, getTheLabelforAwsLb[_])
}

pass[resource]{
    resource := input[_]
    label := getTheLabelforAwsLb[_]
    not isValidResourceAttachedForAwsLb
    not contains(resource.Attributes.load_balancer_arn, label)
}

pass[resource]{
    resource := input[_]
    isValidResourceAttachedForAwsAlb
    contains(resource.Attributes.load_balancer_arn, getTheLabelforAwsAlb[_])
}

pass[resource]{
    resource := input[_]
    label := getTheLabelforAwsAlb[_]
    not isValidResourceAttachedForAwsAlb
    not contains(resource.Attributes.load_balancer_arn, label)
}

pass[resource]{
    resource := input[_]
    isValidResourceAttachedForAwsAlb
    contains(resource.Attributes.load_balancer_arn, getTheLabelforAwsLb[_])
}

pass[resource]{
    resource := input[_]
    isValidResourceAttachedForAwsLb
    contains(resource.Attributes.load_balancer_arn, getTheLabelforAwsAlb[_])
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
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
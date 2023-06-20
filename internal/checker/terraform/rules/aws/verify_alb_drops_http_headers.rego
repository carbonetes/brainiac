# METADATA
# title: "Verify that ALB drops HTTP headers"
# description: "Dropping HTTP headers helps in scenarios where you want to remove sensitive or unnecessary information that might be present in incoming requests."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.4.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_130
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_130

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

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.drop_invalid_header_fields == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ALB drops HTTP headers",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "ALB 'drop_invalid_header_fields' should be set to true",
                "snippet": block}
}

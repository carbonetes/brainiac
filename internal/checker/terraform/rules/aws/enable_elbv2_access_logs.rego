# METADATA
# title: "Verify that ELBv2 (Application/Network) has access logging enabled"
# description: "By enabling access logging for the ELBv2 (Application/Network), detailed records of incoming requests and traffic patterns are captured, providing crucial insights for troubleshooting, security analysis, and performance optimization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#access_logs
# custom:
#   id: CB_TFAWS_098
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_098

supportedResource := ["aws_lb", "aws_alb"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "access_logs"
    has_attribute(resource.Blocks[_].Attributes, "enabled")
    resource.Blocks[_].Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_lb' or 'aws_alb' for 'access_logs' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_lb' or 'aws_alb' for 'access_logs' should be set.",
                "snippet": block }
} 
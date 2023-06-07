# METADATA
# title: "Verify Instance Metadata Service Version 1 is not enabled"
# description: "Disabling Instance Metadata Service Version 1 helps to mitigate security risks and ensures that your EC2 instances are protected against unauthorized access and data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration.html
# custom:
#   id: CB_TFAWS_089
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_089

import future.keywords.in 

supportedResources := ["aws_instance", "aws_launch_configuration", "aws_launch_template"]
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "metadata_options"
    block.Attributes.http_tokens = "required"
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "metadata_options"
    block.Attributes.http_endpoint = "disabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Instance Metadata Service Version 1 is not enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Instance Metadata Service Version 1 should not be enabled",
                "snippet": block }
}

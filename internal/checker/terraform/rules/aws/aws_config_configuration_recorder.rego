# METADATA
# title: "Make sure that AWS Config captures all potential resources"
# description: "This requirement mandates that AWS Config, a configuration management service, must be configured to comprehensively record and monitor all eligible resources within an AWS environment"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder.html
# custom:
#   id: CB_TFAWS_346
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_346

isvalid(block) {
	block.Type == "resource"
    block.Labels[_] == "aws_config_configuration_recorder"
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    innerBlock := resource.Blocks[_]
    innerBlock.Type == "recording_group"
    innerBlock.Attributes.include_global_resource_types == true
}

fail[resource] {
	resource := input[_]
    isvalid(resource)
    not pass[resource]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

passed[result] {
	block := pass[_]
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the Comprehend Entity Recognizer's volume.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the Comprehend Entity Recognizer's volume.",
                "snippet": block }
} 
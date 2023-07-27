# METADATA
# title: "Verify that the State Machine includes active X-Ray tracing functionality"
# description: "This check verifies if the AWS State Machine has X-Ray tracing activated. X-Ray tracing provides valuable insights into the State Machine's execution, aiding in debugging and optimizing performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine.html
# custom:
#   id: CB_TFAWS_267
#   severity: HIGH
package lib.terraform.CB_TFAWS_267

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_sfn_state_machine"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "tracing_configuration"
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
	result := { "message": "AWS State Machine has X-Ray tracing activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS State Machine must have X-Ray tracing activated.",
                "snippet": block }
} 
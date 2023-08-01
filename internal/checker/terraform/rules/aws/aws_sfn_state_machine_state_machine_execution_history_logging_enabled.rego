# METADATA
# title: "Guarantee that the State Machine has active execution history logging"
# description: "Enforce logging of execution history for State Machines to track and monitor workflow execution events effectively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine.html
# custom:
#   id: CB_TFAWS_268
#   severity: HIGH
package lib.terraform.CB_TFAWS_268

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
    resource.Blocks[_].Type == "logging_configuration"
    has_attribute(resource.Blocks[_].Attributes, "include_execution_data")
    resource.Blocks[_].Attributes.include_execution_data == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS State Machine has execution history logging activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS State Machine must have execution history logging activated.",
                "snippet": block }
} 
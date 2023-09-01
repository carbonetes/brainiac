# METADATA
# title: "Verify Global Accelerator accelerator has flow logs enabled"
# description: "Flow logs capture detailed information about each network request, including source and destination IP addresses, ports, protocols, and other relevant metadata."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_accelerator
# custom:
#   id: CB_TFAWS_084
#   severity: LOW
package lib.terraform.CB_TFAWS_084

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_globalaccelerator_accelerator"
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
    block.Type == "attributes"
    block.Attributes.flow_logs_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_globalaccelerator_accelerator' 'flow_logs_enabled' attribute is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_globalaccelerator_accelerator' 'flow_logs_enabled' attribute should be set to true.",
                "snippet": block }
}

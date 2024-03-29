# METADATA
# title: "Verify DLM cross region events are encrypted"
# description: "By encrypting the DLM events, you can protect the integrity and confidentiality of the event data as it travels between regions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy.html#action
# custom:
#   id: CB_TFAWS_234
#   severity: LOW
package lib.terraform.CB_TFAWS_234

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dlm_lifecycle_policy"
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
    resource.Blocks[_].Type == "policy_details"
    resource.Blocks[_].Blocks[_].Type == "action"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "cross_region_copy"
    resource.Blocks[_].Blocks[_].Blocks[_].Blocks[_].Type == "encryption_configuration"
    resource.Blocks[_].Blocks[_].Blocks[_].Blocks[_].Attributes.encryption == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DLM cross region events are encrypted",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "DLM cross region events must be encrypted",
                "snippet": block }
}

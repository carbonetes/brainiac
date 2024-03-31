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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_dlm_lifecycle_policy"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "policy_details"
    some block_type in block.Blocks
    block_type.Type == "action"
    some nested_block_type in block_type.Blocks
    nested_block_type.Type == "cross_region_copy"
    some nested_block in nested_block_type.Blocks
    nested_block.Type == "encryption_configuration"
    nested_block.Attributes.encryption == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "DLM cross region events are encrypted",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "DLM cross region events must be encrypted",
                "snippet": block }
}

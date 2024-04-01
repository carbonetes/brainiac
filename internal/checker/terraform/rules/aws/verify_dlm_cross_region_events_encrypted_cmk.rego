# METADATA
# title: "Verify DLM cross region events are encrypted with Customer Managed Key"
# description: "This adds an extra layer of security and control over your data, reducing the risk of unauthorized access or data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy.html#action
# custom:
#   id: CB_TFAWS_236
#   severity: LOW
package lib.terraform.CB_TFAWS_236
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
    some blocks in block.Blocks
    blocks.Type == "action"
    some block_type in blocks.Blocks
    block_type.Type == "cross_region_copy"
    some nested_block in block_type.Blocks
    nested_block.Type == "encryption_configuration"
    nested_block.Attributes.encryption == true
    nested_block.Attributes.cmk_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "DLM cross region events are encrypted with Customer Managed Key",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "DLM cross region events must be encrypted with Customer Managed Key",
                "snippet": block }
}

# METADATA
# title: "Verify DLM cross region schedules are encrypted"
# description: "By encrypting the schedules, you can protect sensitive information such as the frequency, timing, and targets of the data replication or backup processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy.html#schedule
# custom:
#   id: CB_TFAWS_237
#   severity: LOW
package lib.terraform.CB_TFAWS_237
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_dlm_lifecycle_policy"
    some type in block.Blocks
   	type.Type == "policy_details"
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
    some res in resource.Blocks
    some type in res.Blocks
    type.Type == "schedule"
    some nested_block in type.Blocks
    nested_block.Type == "cross_region_copy_rule"
    nested_block.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "DLM cross region schedules are encrypted",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "DLM cross region schedules must be encrypted",
                "snippet": block }
}
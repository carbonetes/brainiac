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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dlm_lifecycle_policy"
    block.Blocks[_].Type == "policy_details"
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
    resource.Blocks[_].Blocks[_].Type == "schedule"
    resource.Blocks[_].Blocks[_].Blocks[_].Type == "cross_region_copy_rule"
    resource.Blocks[_].Blocks[_].Blocks[_].Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DLM cross region schedules are encrypted",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "DLM cross region schedules must be encrypted",
                "snippet": block }
}

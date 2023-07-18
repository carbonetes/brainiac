# METADATA
# title: "Verify DLM cross region schedules are encrypted using a Customer Managed Key"
# description: "By using a CMK for encryption, you have full control over the encryption keys and can manage their lifecycle according to your organization's security policies."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy.html#schedule
# custom:
#   id: CB_TFAWS_238
#   severity: LOW
package lib.terraform.CB_TFAWS_238

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
    resource.Blocks[_].Blocks[_].Blocks[_].Attributes.cmk_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DLM cross region schedules are encrypted using a Customer Managed Key ",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "DLM cross region schedules must be encrypted using a Customer Managed Key",
                "snippet": block }
}

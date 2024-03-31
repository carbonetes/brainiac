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
    some block in res.Blocks
    block.Type == "schedule"
    some nestec_block in block.Blocks
    nestec_block.Type == "cross_region_copy_rule"
    nestec_block.Attributes.encrypted == true
    nestec_block.Attributes.cmk_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "DLM cross region schedules are encrypted using a Customer Managed Key ",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "DLM cross region schedules must be encrypted using a Customer Managed Key",
                "snippet": block }
}

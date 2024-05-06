# METADATA
# title: "Verify that AMI copying uses a CMK"
# description: "By specifying a Customer Master Key (CMK) using the `kms_key_id` property in the `aws_ami_copy` resource, the copied Amazon Machine Image (AMI) is encrypted with a trusted key, ensuring data security and compliance with regulatory requirements."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_copy#kms_key_id
# custom:
#   id: CB_TFAWS_225
#   severity: LOW
package lib.terraform.CB_TFAWS_225
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ami_copy"
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
    resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AMI copy is configured to use CMK",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "AMI copy should be configured to use CMK",
                "snippet": block }
}

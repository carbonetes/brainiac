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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ami_copy"
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
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AMI copy is configured to use CMK",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AMI copy should be configured to use CMK",
                "snippet": block }
}

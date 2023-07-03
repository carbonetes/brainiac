# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the Image Builder component"
# description: "This quick test verifies that the Image Builder component encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/imagebuilder_component
# custom:
#   id: CB_TFAWS_171
#   severity: LOW
package lib.terraform.CB_TFAWS_171

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_imagebuilder_component"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the Image Builder component.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the Image Builder component.",
                "snippet": block }
} 
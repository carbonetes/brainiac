# METADATA
# title: "Verify that KMS key is enabled"
# description: "By enabling the KMS key with the `is_enabled` property, sensitive data can be securely encrypted and decrypted, providing an essential layer of protection against unauthorized access and ensuring the confidentiality and integrity of critical information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#is_enabled
# custom:
#   id: CB_TFAWS_199
#   severity: LOW
package lib.terraform.CB_TFAWS_199

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_kms_key"
}

has_attribute(key, value) {
  _ = key[value]
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
    not has_attribute(resource.Attributes, "is_enabled")
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.is_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_kms_key' for 'is_enabled' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_kms_key' for 'is_enabled' should be set.",
                "snippet": block}
}



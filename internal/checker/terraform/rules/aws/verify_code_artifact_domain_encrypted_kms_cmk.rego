# METADATA
# title: "Verify Code artifact Domain is encrypted by KMS using a customer managed Key (CMK)"
# description: "By encrypting the CodeArtifact domain with a customer managed key, you can have greater control over the encryption process and ensure that only authorized users with the appropriate key can access and decrypt the artifacts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codeartifact_repository_permissions_policy
# custom:
#   id: CB_TFAWS_212
#   severity: LOW
package lib.terraform.CB_TFAWS_212

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codeartifact_domain"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    has_attribute(blocks.Attributes, "encryption_key")
    blocks.Attributes.encryption_key != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_codeartifact_domain' encryption_key is set properly",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_codeartifact_domain' encryption_key must be set",
                "snippet": block }
} 
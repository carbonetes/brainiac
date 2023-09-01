# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the MemoryDB snapshot"
# description: "This quick test verifies that the MemoryDB snapshot encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/memorydb_snapshot
# custom:
#   id: CB_TFAWS_259
#   severity: HIGH
package lib.terraform.CB_TFAWS_259

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_memorydb_snapshot"
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
    has_attribute(resource.Attributes, "kms_key_arn")
    resource.Attributes.kms_key_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the MemoryDB snapshot.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the MemoryDB snapshot.",
                "snippet": block }
} 
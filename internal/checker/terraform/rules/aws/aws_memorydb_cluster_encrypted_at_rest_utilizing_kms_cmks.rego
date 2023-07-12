# METADATA
# title: "Verify KMS CMKs are being used to encrypt MemoryDB at rest"
# description: "In accordance with this policy, MemoryDB that use default KMS keys rather than customer-managed keys for encryption are identified. To encrypt your MemoryDB data, it is recommended that you utilize customer-managed KMS Keys. You are granted total control on the encrypted data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/memorydb_cluster
# custom:
#   id: CB_TFAWS_192
#   severity: LOW
package lib.terraform.CB_TFAWS_192

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_memorydb_cluster"
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
	result := { "message": "MemoryDB are CMK encrypted.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MemoryDB must be CMK encrypted.",
                "snippet": block }
} 
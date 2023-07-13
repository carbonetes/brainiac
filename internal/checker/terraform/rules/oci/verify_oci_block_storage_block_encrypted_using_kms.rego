# METADATA
# title: "Verify OCI Block Storage Block Volumes are encrypted with a Customer Managed Key (CMK)"
# description: "By verifying this requirement, you can ensure that all block volumes in your OCI environment are encrypted using a customer-managed key, rather than relying on default encryption mechanisms."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume
# custom:
#   id: CB_TFOCI_004
#   severity: HIGH
package lib.terraform.CB_TFOCI_004


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_volume"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    has_attribute(blocks.Attributes, "kms_key_id")
    blocks.Attributes.kms_key_id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Block Storage Block Volume is encrypted with a Customer Managed Key (CMK).",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Block Storage Block Volume should be encrypted with a Customer Managed Key (CMK).",
                "snippet": block }
}
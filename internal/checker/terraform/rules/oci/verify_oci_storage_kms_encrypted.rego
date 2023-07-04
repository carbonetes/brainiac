# METADATA
# title: "Verify OCI Object Storage is encrypted with Customer Managed Key"
# description: "Encrypting OCI Object Storage with a CMK helps meet compliance requirements and mitigates the risk of unauthorized access or data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_object.html
# custom:
#   id: CB_TFOCI_010
#   severity: HIGH
package lib.terraform.CB_TFOCI_010

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_objectstorage_bucket"
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
	result := { "message": "'oci_objectstorage_bucket'is encrypted with Customer Managed Key",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_objectstorage_bucket' should be encrypted with Customer Managed Key'",
                "snippet": block }
}
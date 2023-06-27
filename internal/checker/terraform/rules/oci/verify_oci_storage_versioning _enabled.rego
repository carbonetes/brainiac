# METADATA
# title: "Verify OCI Object Storage has versioning enabled"
# description: "Enabling versioning for OCI Object Storage provides a range of benefits. It ensures that previous versions of objects are retained, allowing easy recovery in case of accidental deletions or modifications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_object.html
# custom:
#   id: CB_TFOCI_009
#   severity: HIGH
package lib.terraform.CB_TFOCI_009

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

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    blocks.Attributes.versioning == "Enabled"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_objectstorage_bucket' versioning is set properly",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_objectstorage_bucket' versioning should be set to 'Enabled'",
                "snippet": block }
}
# METADATA
# title: "Verify OCI Object Storage is not Public"
# description: "By ensuring that the object storage buckets are not publicly accessible, you prevent unauthorized access and potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_object.html
# custom:
#   id: CB_TFOCI_011
#   severity: HIGH
package lib.terraform.CB_TFOCI_011

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

fail[blocks]{
    blocks := input[_]
	isvalid(blocks)
    fobiddenValues := ["ObjectRead", "ObjectReadWithoutList"]
    blocks.Attributes.access_type == fobiddenValues[_]
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Object Storage is not Public",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Object Storage should not be Public",
                "snippet": block }
}
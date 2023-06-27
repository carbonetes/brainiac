# METADATA
# title: "Verify OCI Object Storage bucket can emit object events"
# description: "Enabling object event notifications for OCI Object Storage bucket allows real-time monitoring, automation workflows, improved data management, and enhanced troubleshooting and auditing capabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_object.html
# custom:
#   id: CB_TFOCI_008
#   severity: HIGH
package lib.terraform.CB_TFOCI_008

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
    blocks.Attributes.object_events_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'oci_objectstorage_bucket' object_events_enabled is true",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_objectstorage_bucket' object_events_enabled should be set to true",
                "snippet": block }
}
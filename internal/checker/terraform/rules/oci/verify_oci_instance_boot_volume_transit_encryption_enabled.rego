# METADATA
# title: "Verify OCI Compute Instance boot volume has in-transit data encryption enabled"
# description: "By enabling in-transit data encryption, any data being transferred to and from the boot volume of the compute instance is encrypted, reducing the risk of unauthorized access or data interception."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume
# custom:
#   id: CB_TFOCI_005
#   severity: HIGH
package lib.terraform.CB_TFOCI_005

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_core_instance"
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
    blocks.Blocks[_].Type == "launch_options"
    blocks.Blocks[_].Attributes.is_pv_encryption_in_transit_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Compute Instance boot volume has in-transit data encryption enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Compute Instance boot volume should be in-transit data encryption enabled.",
                "snippet": block }
}
# METADATA
# title: "Verify OCI Compute Instance has Legacy MetaData service endpoint disabled"
# description: "By disabling the Legacy Metadata service endpoint, you can prevent unauthorized access and potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance#are_legacy_imds_endpoints_disabled
# custom:
#   id: CB_TFOCI_006
#   severity: HIGH
package lib.terraform.CB_TFOCI_006

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
    blocks.Blocks[_].Type == "instance_options"
    blocks.Blocks[_].Attributes.are_legacy_imds_endpoints_disabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Compute Instance has Legacy MetaData service endpoint disabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Compute Instance Legacy MetaData service endpoint should be disabled.",
                "snippet": block }
}
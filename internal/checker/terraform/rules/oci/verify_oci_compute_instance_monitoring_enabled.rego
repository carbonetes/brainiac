# METADATA
# title: "Verify OCI Compute Instance has monitoring enabled"
# description: "This allows you to proactively identify and address any issues, optimize resource allocation, and ensure the overall availability and reliability of your infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance#is_monitoring_disabled
# custom:
#   id: CB_TFOCI_007
#   severity: HIGH
package lib.terraform.CB_TFOCI_007

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

fail[blocks]{
    blocks := input[_]
	isvalid(blocks)
    blocks.Blocks[_].Type == "agent_config"
    blocks.Blocks[_].Attributes.is_monitoring_disabled == true
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Compute Instance has monitoring enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Compute Instance monitoring should be enabled",
                "snippet": block }
}
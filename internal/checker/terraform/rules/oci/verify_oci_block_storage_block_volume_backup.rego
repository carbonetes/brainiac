# METADATA
# title: "Verify OCI Block Storage Block Volume has backup enabled"
# description: "By enabling backups, you can create regular snapshots of the block volume, allowing you to restore data to a previous state in case of accidental deletions, data corruption, or system failures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume
# custom:
#   id: CB_TFOCI_002
#   severity: HIGH
package lib.terraform.CB_TFOCI_002


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
    has_attribute(blocks.Attributes, "backup_policy_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI Block Storage Block Volume has backup enabled",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI Block Storage Block Volume should be backup enabled",
                "snippet": block }
}
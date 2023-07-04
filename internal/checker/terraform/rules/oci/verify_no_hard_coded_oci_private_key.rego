# METADATA
# title: "Verify no hard coded OCI private key in provider"
# description: "By avoiding the inclusion of sensitive information, such as the private key, directly in the provider configuration, potential vulnerabilities and unauthorized access are mitigated."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs
# custom:
#   id: CB_TFOCI_001
#   severity: HIGH
package lib.terraform.CB_TFOCI_001

isvalid(block){
	block.Type == "provider"
    block.Labels[_] == "oci"
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

fail[blocks]{
    blocks := input[_]
	isvalid(blocks)
    has_attribute(blocks.Attributes, "private_key_password")
    blocks.Attributes.private_key_password != ""
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No hard coded OCI private key in provider",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "There should be no hard coded OCI private key in provider",
                "snippet": block }
}
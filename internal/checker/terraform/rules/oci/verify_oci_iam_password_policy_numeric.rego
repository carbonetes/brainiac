# METADATA
# title: "Verify OCI IAM password policy - must contain Numeric characters"
# description: "Enforcing the inclusion of numeric characters in passwords adds an additional layer of security to OCI IAM accounts, making them more resistant to brute-force attacks and increasing the overall security posture of your OCI environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_authentication_policy
# custom:
#   id: CB_TFOCI_013
#   severity: HIGH
package lib.terraform.CB_TFOCI_013

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_identity_authentication_policy"
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
    blocks.Blocks[_].Type == "password_policy"
    blocks.Blocks[_].Attributes.is_numeric_characters_required == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI IAM password policy required numeric characters.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI IAM password policy must required numeric characters.",
                "snippet": block }
}
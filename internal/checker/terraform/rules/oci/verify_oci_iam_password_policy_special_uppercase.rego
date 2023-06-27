# METADATA
# title: "Verify OCI IAM password policy - must contain Uppercase characters"
# description: "Enforcing the presence of uppercase characters in passwords adds an additional layer of protection to OCI IAM accounts, making them more resilient against brute-force attacks and enhancing the overall security of your OCI environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_authentication_policy
# custom:
#   id: CB_TFOCI_015
#   severity: HIGH
package lib.terraform.CB_TFOCI_015

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
    blocks.Blocks[_].Attributes.is_uppercase_characters_required == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI IAM password policy required uppercase characters.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI IAM password policy must required uppercase characters.",
                "snippet": block }
}
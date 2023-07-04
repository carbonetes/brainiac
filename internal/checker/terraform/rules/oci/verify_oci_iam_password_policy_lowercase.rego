# METADATA
# title: "Verify OCI IAM password policy - must contain lower case"
# description: "Verifying the OCI IAM password policy for lower case letters ensures that passwords meet a minimum level of complexity and security. By enforcing the presence of lower case letters in passwords, this policy helps protect user accounts and sensitive data from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_identity_provider
# custom:
#   id: CB_TFOCI_012
#   severity: HIGH
package lib.terraform.CB_TFOCI_012 

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
    blocks.Blocks[_].Attributes.is_lowercase_characters_required == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "OCI IAM password policy required lower case.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "OCI IAM password policy must required lower case.",
                "snippet": block }
}
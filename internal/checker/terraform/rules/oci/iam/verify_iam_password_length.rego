# METADATA
# title: "Verify that IAM password policy for local (non-federated) users has a minimum length of 14 characters"
# description: "By enforcing a minimum password length of 14 characters for local users, the OCI IAM password policy enhances security by promoting the use of stronger, more resilient passwords, thus reducing the risk of unauthorized access and potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_authentication_policy#minimum_password_length
# custom:
#   id: CB_TFOCI_018
#   severity: HIGH
package lib.terraform.CB_TFOCI_018

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "oci_identity_authentication_policy"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
}

pass[resource] {
	resource := input[_]
    isvalid(resource)

    to_number(resource.Blocks[_].Attributes.minimum_password_length) >= 14
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}




passed[result] {
	block := pass[_]
	result := { "message": "'oci_identity_authentication_policy' for 'minimum_password_length' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'oci_identity_authentication_policy' for 'minimum_password_length' should be set.",
                "snippet": block }
} 
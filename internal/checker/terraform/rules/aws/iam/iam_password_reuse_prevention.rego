# METADATA
# title: "Make sure IAM password policy prevents password reuse"
# description: "It reduces the likelihood of unauthorized access to systems and data, as well as mitigates the risk of password-based attacks, such as brute-force attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#password_reuse_prevention
# custom:
#   id: CB_TFAWS_013
#   severity: HIGH
package lib.terraform.CB_TFAWS_013

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_account_password_policy"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    reusePasswordInt := to_number(resource.Attributes.password_reuse_prevention)
    reusePasswordInt <= 24
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'password_reuse_prevention' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'password_reuse_prevention' should be set to and to be set less than 24",
                "snippet": block }
}
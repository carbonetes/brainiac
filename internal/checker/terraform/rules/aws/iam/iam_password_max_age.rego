# METADATA
# title: "Make sure that the IAM password policy mandates passwords to expire within 90 days or less."
# description: "Passwords that remain unchanged for extended periods of time can be more easily compromised, as attackers may have more time to guess or obtain them."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#max_password_age
# custom:
#   id: CB_TFAWS_008
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_008

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
    maxAge := to_number(resource.Attributes.max_password_age)
    maxAge <= 90
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'max_password_age' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'max_password_age' should be set to 90 days or less",
                "snippet": block }
}
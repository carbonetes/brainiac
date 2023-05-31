# METADATA
# title: "Make sure IAM password policy requires at least one number"
# description: "Requiring at least one number in IAM password policy ensures that passwords are more complex and less susceptible to being guessed or easily cracked by attackers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_numbers
# custom:
#   id: CB_TFAWS_012
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_012

import future.keywords.in 


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
    resource.Attributes.require_numbers = true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_numbers' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_numbers' should be set to true",
                "snippet": block }
}
# METADATA
# title: "Make sure IAM password policy requires at least one symbol"
# description: "Requiring the use of symbols in passwords can make them more complex and harder to guess or crack through brute-force attacks, therefore increasing the security of the IAM user accounts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_symbols
# custom:
#   id: CB_TFAWS_015
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_015

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
    resource.Attributes.require_symbols = true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_symbols' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_symbols' should be set to true",
                "snippet": block }
}
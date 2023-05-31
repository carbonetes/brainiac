# METADATA
# title: "Make sure IAM password policy requires at least one lowercase letter"
# description: "Making sure IAM password policy requires at least one lowercase letter helps to strengthen password security by enforcing the use of a mix of characters in passwords"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_lowercase_characters
# custom:
#   id: CB_TFAWS_010
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_010

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
    resource.Attributes.require_lowercase_characters = true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_lowercase_characters' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_lowercase_characters' should be set to true",
                "snippet": block }
}
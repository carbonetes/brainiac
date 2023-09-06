# METADATA
# title: "Make sure IAM password policy requires at least one uppercase letter"
# description: "Making sure IAM password policy requires at least one uppercase letter helps to strengthen password security by enforcing the use of a mix of characters in passwords"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_uppercase_characters
# custom:
#   id: CB_TFAWS_018
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_018

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
    resource.Attributes.require_uppercase_characters = true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_uppercase_characters' is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_account_password_policy' 'require_uppercase_characters' should be set to true",
                "snippet": block }
}
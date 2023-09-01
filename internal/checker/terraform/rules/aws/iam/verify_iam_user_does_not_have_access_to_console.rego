# METADATA
# title: "Verify an IAM User does not have access to the console"
# description: "By enforcing this policy, organizations can enhance their AWS account security by restricting console access to only authorized individuals or roles, aligning with the principle of least privilege."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user.html
# custom:
#   id: CB_TFAWS_318
#   severity: HIGH
package lib.terraform.CB_TFAWS_318

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_user"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getIamUserLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_user"
    label := concat(".", resource.Labels)
}

isIAMUserLoginIsLinked{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_iam_user_login_profile"
    label := getIamUserLabel[_]
    startswith(resource.Attributes.user, label)

}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    isIAMUserLoginIsLinked
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": " IAM User does not have access to the console.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": " IAM User does should not have access to the console.",
                "snippet": block }
} 
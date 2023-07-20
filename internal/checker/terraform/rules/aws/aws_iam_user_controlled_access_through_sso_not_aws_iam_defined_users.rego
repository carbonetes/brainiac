# METADATA
# title: "Verify that access is managed via Single Sign-On (SSO) rather than AWS IAM defined users"
# description: "Implement access control through Single Sign-On (SSO) instead of AWS IAM-defined users to enhance security and user management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user
# custom:
#   id: CB_TFAWS_249
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_249

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_user"
}

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource] {
    resource := input[_]
	isvalid(resource)
}

failed[result] {
    block := fail[_]
	result := { "message": "Access is granted to AWS IAM defined users.",
                "snippet": block }
} 
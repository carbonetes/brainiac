# METADATA
# title: "Aim to prevent the creation of IAM policies that grant full administrative privileges."
# description: "Users, groups, and roles are granted privileges through the use of IAM policies. It is advisable to avoid granting full administrative access, as this could expose resources to potentially undesirable behaviors."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
# custom:
#   id: CB_TFAWS_061
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_061

import future.keywords.in 

supportedResource := ["aws_iam_group_policy", "aws_iam_policy", "aws_iam_role_policy", "aws_iam_user_policy", "aws_ssoadmin_permission_set_inline_policy"]


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
    block := input[_]
    isvalid(block)
    block.Type == "resource"
    policyStr := block.Attributes.policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect == "Allow"
    contains(statement.Action, "*")
    contains(statement.Resource, "*")
}


pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Full administrative privileges are denied.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Full administrative privileges must be denied.",
                "snippet": block}
}

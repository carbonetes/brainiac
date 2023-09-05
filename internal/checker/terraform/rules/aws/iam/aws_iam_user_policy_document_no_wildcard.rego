# METADATA
# title: "IAM policy documents should disallow the utilization of (*) as the action within any statement"
# description: "It is advised to avoid allowing asterisk (all resource) statements in the action elements of IAM policy documents. Allowing such broad access could lead to uncontrolled and undesired access by individuals covered by the policy."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
# custom:
#   id: CB_TFAWS_063
#   severity: HIGH
package lib.terraform.CB_TFAWS_063

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
	result := { "message": "Using asterisk on policy documents are denied.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Using asterisk on policy documents should be denied.",
                "snippet": block}
}

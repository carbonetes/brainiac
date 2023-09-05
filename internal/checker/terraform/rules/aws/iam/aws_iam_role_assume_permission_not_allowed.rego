# METADATA
# title: "Make that the AWS IAM policy prohibits the assumption of roles for all services"
# description: "Detailed roles must be specified for particular services or guiding concepts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_064
#   severity: HIGH
package lib.terraform.CB_TFAWS_064

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_iam_role"
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
    policyStr := block.Attributes.assume_role_policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect == "Allow"
    accountPattern := "^(\\d{12}|arn:aws:iam::\\d{12}:root)$"
    re_match(accountPattern, statement.Principal.AWS)
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Role permission on all services is denied.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Role permission on all services should be denied.",
                "snippet": block}
}

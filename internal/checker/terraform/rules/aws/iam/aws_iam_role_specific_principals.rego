# METADATA
# title: "Verify that the IAM role permits exclusive authorization for designated services or principals to assume its privileges"
# description: "Restrict the list of allowed principals to assume a role, avoiding the use of wildcard (*) which grants access to any authenticated identity in AWS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_058
#   severity: HIGH
package lib.terraform.CB_TFAWS_058

import future.keywords.in 


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
    block.Type == "resource"
    policyStr := block.Attributes.assume_role_policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect == "Allow"
    contains(statement.Principal.AWS, "*")
}


pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No wildcard is used in the Principal.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Wildcard should not  be used in the Principal.",
                "snippet": block}
}

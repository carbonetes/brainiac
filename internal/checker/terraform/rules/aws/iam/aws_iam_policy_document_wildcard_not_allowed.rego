# METADATA
# title: "Make sure that none of the IAM policies allow a statement's actions to use a wildcard."
# description: "We advise against utilizing wildcard declarations as action items. Given how the policy document is written up, this degree of access might provide anyone unwelcome and uncontrolled access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_042
#   severity: HIGH
package lib.terraform.CB_TFAWS_042

import future.keywords.in 


isvalid(block){
	block.Type == "data"
    block.Labels[_] == "aws_iam_policy_document"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[blockStatements] {
    block := input[_]
	isvalid(block)
    blockStatements := block.Blocks[_]
    blockStatements.Type == "statement"
    blockStatements.Attributes.effect  == "Allow"
    action := blockStatements.Attributes.actions[_]
    action == "*"
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	blockStatements := pass[_]
	result := { "message": "The attribute statement for actions does not contain wildcard",
                "snippet": blockStatements}
}

failed[result] {
    blockStatements := fail[_]
	result := { "message": "The attribute for actions should not contain wildcard",
                "snippet": blockStatements }
}

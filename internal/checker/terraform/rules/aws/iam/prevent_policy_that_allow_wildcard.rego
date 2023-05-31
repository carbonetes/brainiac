# METADATA
# title: "Prevent the creation of IAM policies that grant full administrative privileges using wildcard characters for both the actions and resources."
# description: "Using wildcards for both actions and resources can lead to excessive permissions that can be exploited by attackers to gain unauthorized access to resources, escalate privileges, and cause damage to the system."
# scope: package
# related_resources:
# - https://learn.hashicorp.com/terraform/aws/iam-policy
# custom:
#   id: CB_TFAWS_001
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_001

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
    resource := blockStatements.Attributes.resources[_]
    resource == "*"
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}



passed[result] {
	blockStatements := pass[_]
	result := { "message": "The attribute statement for actions and resources does not contain wildcard",
                "snippet": blockStatements}
}

failed[result] {
    blockStatements := fail[_]
	result := { "message": "The attribute for actions and resources should not contain wildcard",
                "snippet": blockStatements }
}
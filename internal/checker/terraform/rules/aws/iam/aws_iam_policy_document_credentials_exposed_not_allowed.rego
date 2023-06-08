# METADATA
# title: "Make certain that IAM policies prohibit the disclosure of credentials"
# description: "Prevent credentials exposure in IAM policies for ECR by reviewing and modifying policies, applying the principle of least privilege, and implementing additional security measures like MFA."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_100
#   severity: LOW
package lib.terraform.CB_TFAWS_100

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

fail[blockStatements]{
    block := input[_]
	isvalid(block)
    blockStatements := block.Blocks[_]
    blockStatements.Type == "statement"
    blockStatements.Attributes.actions[_]  == "iam:CreateAccessKey"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "IAM policy credential exposure disabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "IAM policy credential exposure should be disabled.",
                "snippet": block }
}

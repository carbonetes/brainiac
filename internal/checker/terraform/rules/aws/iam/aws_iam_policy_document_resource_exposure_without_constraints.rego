# METADATA
# title: "Make certain that IAM policies prohibit managing permissions and exposing resources without restrictions"
# description: "This policy enables actions that allow for the alteration of resource-based policies or have the potential to expose AWS resources to the public. These actions have similarities to actions that can lead to the exposure of resources, which may pose security and confidentiality risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_115
#   severity: LOW
package lib.terraform.CB_TFAWS_115

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
    noConstraints := ["iam:*","ec2:*", "s3:*", "sns:*", "sqs:*", "lambda:*", "kms:*", "cloudformation:*", "rds:*", "*"]
    block := input[_]
	isvalid(block)
    blockStatements := block.Blocks[_]
    blockStatements.Type == "statement"
    blockStatements.Attributes.effect  == "Allow"
    blockStatements.Attributes.actions[_]  == noConstraints[_]
    blockStatements.Attributes.resources[_]  == "*"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "IAM policies restrict permissions management / resource exposure without constraints.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "IAM policies should restrict permissions management / resource exposure without constraints.",
                "snippet": block}
}

# METADATA
# title: "Make certain IAM policies prohibit unrestricted write access."
# description: "This policy permits activities that enable the alteration of resource-based policies or that, in other ways, may expose AWS resources to the public through comparable actions that may similarly expose resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_102
#   severity: LOW
package lib.terraform.CB_TFAWS_102

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
    noConstraints := ["s3:*", "S3:PutObject", "dynamodb:PutItem", "sns:Publish", "sqs:SendMessage", "lambda:InvokeFunction", "rds:CreateDBInstance", "ec2:RunInstances", "cloudformation:CreateStack", "sagemaker:CreateTrainingJob", "kinesis:PutRecord", "*"]
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
	result := { "message": "IAM policies restrict write access without constraints.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "IAM policies should restrict write access without constraints.",
                "snippet": block}
}

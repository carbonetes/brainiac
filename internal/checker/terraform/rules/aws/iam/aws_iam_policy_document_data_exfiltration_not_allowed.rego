# METADATA
# title: "Make certain that IAM policies prohibit data exfiltration"
# description: "Data Exfiltration actions, such as s3:GetObject, ssm:GetParameter*, or secretsmanager:GetSecretValue, permit some read-only IAM operations without resource restrictions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_088
#   severity: INFO
package lib.terraform.CB_TFAWS_088

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
    dataExfiltration := ["s3:GetObject", "ssm:GetParameter",  "ssm:GetParameters", "ssm:GetParametersByPath", "ssm:GetParameter*", "secretsmanager:GetSecretValue", "*"]
    block := input[_]
	isvalid(block)
    blockStatements := block.Blocks[_]
    blockStatements.Type == "statement"
    blockStatements.Attributes.effect  == "Allow"
    blockStatements.Attributes.actions[_]  == dataExfiltration[_]
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "'aws_iam_policy_document' no data exfiltration found.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_iam_policy_document' data exfiltration should not be allowed.",
                "snippet": block}
}

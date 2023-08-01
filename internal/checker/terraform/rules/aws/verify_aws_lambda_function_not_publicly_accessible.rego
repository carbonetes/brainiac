# METADATA
# title: "Verify that AWS Lambda function is not publicly accessible"
# description: "Verifying that AWS Lambda functions are not publicly accessible ensures data security, compliance, cost optimization, and protection against unauthorized access or DDoS attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission.html
# custom:
#   id: CB_TFAWS_277
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_277

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_permission"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.principal != "*"
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS Lambda function is not publicly accessible",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS Lambda function must not publicly accessible",
                "snippet": block }
}

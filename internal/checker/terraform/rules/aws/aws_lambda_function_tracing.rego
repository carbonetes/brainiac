# METADATA
# title: "Ensure that tracing is enabled for AWS Lambda functions"
# description: "When using lambda functions, you can use X-Ray tracing to visualize and diagnose errors, identify performance problems, and look into requests that gave rise to errors."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_026
#   severity: LOW
package lib.terraform.CB_TFAWS_026

import future.keywords.in 

supportedResource := ["aws_lambda_function"]

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Attributes.mode == "Active"
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_lambda_function tracing is active.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_lambda_function tracing should be active.",
                "snippet": block }
}

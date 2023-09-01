# METADATA
# title: "Verify that AWS Lambda function is configured inside a VPC"
# description: " By placing the Lambda function within a VPC, you can isolate it from the public internet, control network connectivity using subnets and security groups, and establish private communication with other resources within the VPC."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_108
#   severity: LOW
package lib.terraform.CB_TFAWS_108


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_function"
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
    block.Type == "vpc_config"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_lambda_function' is VPC configured",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_lambda_function' should be configured inside VPC.",
                "snippet": block }
}

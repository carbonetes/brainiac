# METADATA
# title: "Verify that AWS Lambda function is configured for function-level concurrent execution limit"
# description: "This allows for better resource allocation, prevents performance degradation, and enhances the overall stability and scalability of the Lambda function."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_104
#   severity: LOW
package lib.terraform.CB_TFAWS_104

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_function"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "reserved_concurrent_executions")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_lambda_function' 'reserved_concurrent_executions' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_lambda_function' 'reserved_concurrent_executions' should be set properly.",
                "snippet": block }
} 
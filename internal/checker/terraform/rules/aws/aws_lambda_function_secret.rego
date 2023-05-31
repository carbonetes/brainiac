# METADATA
# title: "Verify the lambda environment for any hard-coded secrets"
# description: "Avoid storing hardcoded keys and secrets in infrastructure code or version-controlled configuration settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_040
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_040

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_function"
}
has_attribute(key, value) {
  _ = key[value]
}

checkRegex(value){
	regex.match("[A-Z0-9]{20}", value)

}

checkRegex(value){
	regex.match("[a-zA-Z0-9/+]{40}", value)
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
  block := input[_]
  isvalid(block)
  envBlock := block.Blocks[_]
  envBlock.Type == "environment"
  variables := envBlock.Attributes.variables[_]
  checkRegex(variables)
}


pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Hard-coded AWS access keys or secret keys not found.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Do not include hard-coded AWS access keys or secret keys.",
                "snippet": block }
}














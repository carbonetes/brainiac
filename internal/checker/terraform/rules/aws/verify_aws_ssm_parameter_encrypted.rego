# METADATA
# title: "Verify AWS SSM Parameter is Encrypted"
# description: "This safeguards sensitive data from unauthorized access or exposure, maintaining the confidentiality and integrity of your critical information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter.html
# custom:
#   id: CB_TFAWS_336
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_336

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ssm_parameter"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.type == "SecureString"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS SSM Parameter is Encrypted.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS SSM Parameter Attributes 'type' should be set to 'SecureString'.",
                "snippet": block }
} 
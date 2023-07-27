# METADATA
# title: "Verify App Flow flow uses CMK"
# description: "By using a CMK for encryption, you can have greater control over the encryption keys and their management, ensuring better security and compliance with data protection standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appflow_flow
# custom:
#   id: CB_TFAWS_257
#   severity: LOW
package lib.terraform.CB_TFAWS_257

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_appflow_flow"
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
    resource.Attributes.kms_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_appflow_flow uses CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_appflow_flow must use CMK.",
                "snippet": block }
} 
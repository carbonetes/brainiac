# METADATA
# title: "Verify App Flow connector profile uses CMK"
# description: "When AppFlow connector profiles use CMK for encryption, the sensitive data exchanged between connectors is safeguarded and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appflow_connector_profile
# custom:
#   id: CB_TFAWS_258
#   severity: LOW
package lib.terraform.CB_TFAWS_258

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_appflow_connector_profile"
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
	result := { "message": "'aws_appflow_connector_profile uses CMK.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_appflow_connector_profile must use CMK.",
                "snippet": block }
} 
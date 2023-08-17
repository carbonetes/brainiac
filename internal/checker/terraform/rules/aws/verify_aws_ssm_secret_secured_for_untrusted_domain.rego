# METADATA
# title: "Verify terraform is not sending SSM secrets to untrusted domains over HTTP"
# description: "By enforcing secure communication through HTTPS, this measure safeguards against potential data exposure and unauthorized access to sensitive information, enhancing the overall security posture of the infrastructure managed by Terraform."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter.html
# custom:
#   id: CB_TFAWS_343
#   severity: HIGH
package lib.terraform.CB_TFAWS_343

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ssm_parameter"
}

isvalid(block){
	block.Type == "data"
    block.Labels[_] == "http"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getssmLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_ssm_parameter"
    label := concat(".", resource.Labels)
}

isHTTPAttachedValid{
    resource := input[_]
    resource.Type == "data"
    resource.Labels[_] == "http"
    contains(resource.Attributes.url, getssmLabel[_])
}

fail[resource]{
    resource := input[_]
	resource.Type == "resource"
    resource.Labels[_] == "aws_ssm_parameter"
    resource.Attributes.type == "SecureString"
    isHTTPAttachedValid
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Terraform is not sending SSM secrets to untrusted domains over HTTP.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Terraform should not sending SSM secrets to untrusted domains over HTTP.",
                "snippet": block }
} 
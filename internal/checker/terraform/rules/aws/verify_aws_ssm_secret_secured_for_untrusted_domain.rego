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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ssm_parameter"
}

isvalid(block) if {
	block.Type == "data"
	some label in block.Labels
	label == "http"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getssmlabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_ssm_parameter" in resource.Labels
	label := concat(".", resource.Labels)
}

is_http_attached_valid if {
	some resource in input
	resource.Type == "data"
	"http" in resource.Labels
	some label in getssmlabel
	contains(resource.Attributes.url, label)
}

fail contains resource if {
	some resource in input
	resource.Type == "resource"
	"aws_ssm_parameter" in resource.Labels
	resource.Attributes.type == "SecureString"
	is_http_attached_valid
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Terraform is not sending SSM secrets to untrusted domains over HTTP.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Terraform should not sending SSM secrets to untrusted domains over HTTP.",
		"snippet": block,
	}
}

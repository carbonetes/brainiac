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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_lambda_permission"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.principal != "*"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS Lambda function is not publicly accessible",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS Lambda function must not publicly accessible",
		"snippet": block,
	}
}

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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_lambda_function"
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
	some block in resource.Blocks
	block.Type == "vpc_config"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_lambda_function' is VPC configured",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_lambda_function' should be configured inside VPC.",
		"snippet": block,
	}
}
# METADATA
# title: "Achieve secure at-rest encryption for all the data kept in the Sagemaker Endpoint"
# description: "Enabling at-rest encryption guarantees that the data on your AWS SageMaker notebook instances comply with legal standards and safeguards your SageMaker data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_endpoint_configuration.html
# custom:
#   id: CB_TFAWS_082
#   severity: HIGH
package lib.terraform.CB_TFAWS_082

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sagemaker_endpoint_configuration"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	has_attribute(resource.Attributes, "kms_key_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Data contained in Sagemaker Endpoint is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Data contained in Sagemaker Endpoint should be is encrypted.",
		"snippet": block,
	}
}
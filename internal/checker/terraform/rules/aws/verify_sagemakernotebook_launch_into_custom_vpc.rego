# METADATA
# title: "Verify SageMaker notebook instances should be launched into a custom VPC"
# description: "Verifying that SageMaker notebook instances are launched into a custom VPC enhances security, control, and network isolation, allowing granular access control, compliance adherence, data privacy, and resource optimization for machine learning workflows in Amazon SageMaker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws2/latest/docs/resources/sagemaker_notebook_instance
# custom:
#   id: CB_TFAWS_288
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_288

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sagemaker_notebook_instance"
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
	resource.Attributes.subnet_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SageMaker notebook instances launched into a custom VPC",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_sagemaker_notebook_instance' subnet_id must be set.",
		"snippet": block,
	}
}

# METADATA
# title: "Verify SageMaker Users should not have root access to SageMaker notebook instances"
# description: "By controlling access and adhering to security best practices, this measure promotes a more secure and controlled environment for machine learning workflows in Amazon SageMaker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws2/latest/docs/resources/sagemaker_notebook_instance
# custom:
#   id: CB_TFAWS_290
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_290

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
	resource.Attributes.root_access == "Disabled"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_sagemaker_notebook_instance' root_access is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_sagemaker_notebook_instance' root_access should be Disabled",
		"snippet": block,
	}
}

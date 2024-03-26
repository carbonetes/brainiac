# METADATA
# title: "Verify SageMaker Notebook is encrypted at rest using KMS CMK"
# description: "This ensures that any sensitive data that may be stored on the notebook instance is protected from unauthorized access in case of data leakage or theft."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance
# custom:
#   id: CB_TFAWS_039
#   severity: HIGH
package lib.terraform.CB_TFAWS_039

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sagemaker_notebook_instance"
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
	has_attribute(resource.Attributes, "kms_key_id")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_sagemaker_notebook_instance' 'kms_key_id' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_sagemaker_notebook_instance' 'kms_key_id' should be set.",
		"snippet": block,
	}
}

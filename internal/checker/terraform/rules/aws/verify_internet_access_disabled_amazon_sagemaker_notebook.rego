# METADATA
# title: "Verify that direct internet access is disabled for an Amazon SageMaker Notebook Instance"
# description: "By disabling direct internet access, the notebook instance is isolated from the public internet, reducing the risk of unauthorized access or data exfiltration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance#direct_internet_access
# custom:
#   id: CB_TFAWS_117
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_117

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
	resource.Attributes.direct_internet_access == "Disabled"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_sagemaker_notebook_instance' direct_internet_access is disabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_sagemaker_notebook_instance' direct_internet_access should be disabled.",
		"snippet": block,
	}
}
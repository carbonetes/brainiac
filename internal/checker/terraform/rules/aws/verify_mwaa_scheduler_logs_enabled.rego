# METADATA
# title: "Verify that MWAA environment has scheduler logs enabled"
# description: "By enabling scheduler logs in an Amazon MWAA environment through Terraform, it is important to gain valuable insights into workflow execution and potential issues, facilitating efficient debugging and optimization of Apache Airflow tasks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
# custom:
#   id: CB_TFAWS_256
#   severity: LOW
package lib.terraform.CB_TFAWS_256

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_mwaa_environment"
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
	resource.Blocks[_].Type == "logging_configuration"
	resource.Blocks[_].Blocks[_].Type == "scheduler_logs"
	resource.Blocks[_].Blocks[_].Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "MWAA environment has scheduler logs enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "MWAA environment does not have scheduler logs enabled.",
		"snippet": block,
	}
}

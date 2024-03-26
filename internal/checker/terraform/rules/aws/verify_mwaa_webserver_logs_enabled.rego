# METADATA
# title: "Verify that MWAA environment has webserver logs enabled"
# description: "By enabling webserver logs in the AWS Managed Apache Airflow (MWAA) environment, it becomes crucial for monitoring and troubleshooting the system, providing valuable insights into the performance and behavior of the webserver, ensuring operational efficiency and better decision-making."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment#logging_configuration
# custom:
#   id: CB_TFAWS_272
#   severity: LOW
package lib.terraform.CB_TFAWS_272

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
	resource.Blocks[_].Blocks[_].Type == "webserver_logs"
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
		"message": "MWAA environment has webserver logs enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "MWAA environment does not have webserver logs enabled.",
		"snippet": block,
	}
}

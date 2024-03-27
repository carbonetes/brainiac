# METADATA
# title: "Verify AWS Config is enabled in all regions"
# description: "Enabling AWS Config in all regions enhances your security and compliance posture by providing visibility and control over your AWS environment on a global scale."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_aggregator.html
# custom:
#   id: CB_TFAWS_116
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_116

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_config_configuration_aggregator"
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
	sources := ["account_aggregation_source", "organization_aggregation_source"]
	block.Type in sources
	block.Attributes.all_regions == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_config_configuration_aggregator' Config is enabled in all regions",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_config_configuration_aggregator' Config should be enabled in all regions",
		"snippet": block,
	}
}
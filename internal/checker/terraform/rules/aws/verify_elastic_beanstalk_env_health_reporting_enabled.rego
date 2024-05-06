# METADATA
# title: "Verify Elastic Beanstalk environments have enhanced health reporting enabled"
# description: "Verifying that Elastic Beanstalk environments have enhanced health reporting enabled ensures improved monitoring and diagnostics for applications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_environment
# custom:
#   id: CB_TFAWS_295
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_295

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elastic_beanstalk_environment"
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
	resource.Blocks[_].Type == "setting"
	some value in resource.Blocks
	validValue(value.Attributes)
}

validValue(attrib) := result if {
	attrib.namespace == "aws:elasticbeanstalk:healthreporting:system"
	attrib.name == "HealthStreamingEnabled"
	attrib.value == true
	result := true
} else := result if {
	attrib.namespace == "aws:elasticbeanstalk:healthreporting:system"
	attrib.name == "HealthStreamingEnabled"
	attrib.value == "true"
	result := true
} else := result if {
	result := false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Elastic Beanstalk environments have enhanced health reporting enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Elastic Beanstalk setting must have health reporting enabled.",
		"snippet": block,
	}
}

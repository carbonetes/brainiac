# METADATA
# title: "Verify MQ Broker is not publicly exposed"
# description: "By configuring the MQ broker to not be publicly accessible, you can prevent unauthorized access and potential attacks on your messaging system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/mq_broker
# custom:
#   id: CB_TFAWS_075
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_075

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_mq_broker"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.publicly_accessible == true
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_mq_broker' 'publicly_accessible' is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_mq_broker' 'publicly_accessible' should be enabled.",
		"snippet": block,
	}
}
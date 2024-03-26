# METADATA
# title: "Check to see if MQ Broker logging is activated"
# description: "Applications can connect with one another utilizing a variety of programming languages, operating systems, and formal messaging protocols thanks to MQ's role as a message broker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_036
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_036

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

pass contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "logs"
    block.Attributes.general == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "aws_mq_broker_logs general is set to true.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "aws_mq_broker_logs general must be set to true.",
                "snippet": block }
}
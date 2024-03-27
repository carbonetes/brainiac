# METADATA
# title: "Make certain MQ Broker Audit logging is activated"
# description: "For AWS MQBroke, it is advised to use an efficient logging procedure in order to monitor human and automated configuration changes and track prohibited ones."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_188
#   severity: LOW
package lib.terraform.CB_TFAWS_188
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_mq_broker"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "logs"
    block.Attributes.audit == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "MQ Broker Audit logging is enabled.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "MQ Broker Audit logging must be enabled.",
                "snippet": block }
}
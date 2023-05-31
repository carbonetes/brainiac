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

import future.keywords.in 

supportedResource := ["aws_mq_broker"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "logs"
    block.Attributes.general == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_mq_broker_logs general is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_mq_broker_logs general must be set to true.",
                "snippet": block }
}

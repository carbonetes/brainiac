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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mq_broker"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "logs"
    resource.Blocks[_].Attributes.audit == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MQ Broker Audit logging is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MQ Broker Audit logging must be enabled.",
                "snippet": block }
} 
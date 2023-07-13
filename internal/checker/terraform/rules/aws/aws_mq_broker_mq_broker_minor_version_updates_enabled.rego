# METADATA
# title: "Verify that MQ Broker minor version updates are active"
# description: "With little impact on the application, minor modifications assist maintain a safe and reliable MQ broker. Therefore, we advise activating your automatic minor upgrade."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_206
#   severity: LOW
package lib.terraform.CB_TFAWS_206

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mq_broker"
}

has_attribute(key, value) {
  _ = key[value]
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
    has_attribute(resource.Attributes, "auto_minor_version_upgrade")
    resource.Attributes.auto_minor_version_upgrade == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MQ Broker minor version updates are activated.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "MQ Broker minor version updates must be activated.",
                "snippet": block }
} 
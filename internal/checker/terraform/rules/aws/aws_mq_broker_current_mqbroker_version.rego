# METADATA
# title: "Verify that the MQBroker version is up to date"
# description: "This evaluation analyzes the engine version value for MQ and highlights any instances where the version falls below the minimum required threshold."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_209
#   severity: LOW
package lib.terraform.CB_TFAWS_209

import future.keywords.in 

supportedResources := ["aws_mq_broker", "aws_mq_configuration"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

has_attribute(key, value) {
  _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.engine_type == "ActiveMQ"
    regex.match("(\\d+\\.\\d+\\.\\d+)", resource.Attributes.engine_version)
    engineVersion := resource.Attributes.engine_version
    major := split(engineVersion, ".")[0]
    minor := split(engineVersion, ".")[1]
    majorNum := to_number(major)
    minorNum := to_number(minor)
    majorNum >= 5
    minorNum >= 16
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.engine_type == "ActiveMQ"
    regex.match("(\\d+\\.\\d+\\.\\d+)", resource.Attributes.engine_version)
    engineVersion := resource.Attributes.engine_version
    major := split(engineVersion, ".")[0]
    minor := split(engineVersion, ".")[1]
    majorNum := to_number(major)
    minorNum := to_number(minor)
    majorNum > 5
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.engine_type == "RabbitMQ"
    regex.match("(\\d+\\.\\d+\\.\\d+)", resource.Attributes.engine_version)
    engineVersion := resource.Attributes.engine_version
    major := split(engineVersion, ".")[0]
    minor := split(engineVersion, ".")[1]
    majorNum := to_number(major)
    minorNum := to_number(minor)
    majorNum >= 3
    minorNum >= 8
}

pass[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.engine_type == "RabbitMQ"
    regex.match("(\\d+\\.\\d+\\.\\d+)", resource.Attributes.engine_version)
    engineVersion := resource.Attributes.engine_version
    major := split(engineVersion, ".")[0]
    minor := split(engineVersion, ".")[1]
    majorNum := to_number(major)
    minorNum := to_number(minor)
    majorNum > 3
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "MQBroker version is up to date",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "MQBroker version must be up to date",
                "snippet": block}
}

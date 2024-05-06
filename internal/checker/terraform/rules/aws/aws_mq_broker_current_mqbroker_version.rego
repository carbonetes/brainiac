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
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["aws_mq_broker", "aws_mq_configuration"]
	label in supported_resource
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
	resource.Attributes.engine_type == "ActiveMQ"
	regex.match(`(\d+\.\d+\.\d+)`, resource.Attributes.engine_version)
	engine_version := resource.Attributes.engine_version
	major := split(engine_version, ".")[0]
	minor := split(engine_version, ".")[1]
	major_num := to_number(major)
	minor_num := to_number(minor)
	major_num >= 5
	minor_num >= 16
}

pass contains resource if {
    some resource in input
	isvalid(resource)
	resource.Attributes.engine_type == "ActiveMQ"
	regex.match(`(\d+\.\d+\.\d+)`, resource.Attributes.engine_version)
	engine_version := resource.Attributes.engine_version
	major := split(engine_version, ".")[0]
	minor := split(engine_version, ".")[1]
	major_num := to_number(major)
	minor_num := to_number(minor)
	major_num > 5
}

pass contains resource if {
    some resource in input
	isvalid(resource)
	resource.Attributes.engine_type == "RabbitMQ"
	regex.match(`(\d+\.\d+\.\d+)`, resource.Attributes.engine_version)
	engine_version := resource.Attributes.engine_version
	major := split(engine_version, ".")[0]
	minor := split(engine_version, ".")[1]
	major_num := to_number(major)
	minor_num := to_number(minor)
	major_num >= 3
	minor_num >= 8
}

pass contains resource if {
    some resource in input
	isvalid(resource)
	resource.Attributes.engine_type == "RabbitMQ"
	regex.match(`(\d+\.\d+\.\d+)`, resource.Attributes.engine_version)
	engine_version := resource.Attributes.engine_version
	major := split(engine_version, ".")[0]
	minor := split(engine_version, ".")[1]
	major_num := to_number(major)
	minor_num := to_number(minor)
	major_num > 3
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
    some block in pass
	result := {
		"message": "MQBroker version is up to date",
		"snippet": block,
	}
}

failed contains result if {
    some block in fail
	result := {
		"message": "MQBroker version must be up to date",
		"snippet": block,
	}
}

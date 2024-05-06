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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_mq_broker"
}

has_attribute(key, value) if {
    value in object.keys(key)
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
    has_attribute(resource.Attributes, "auto_minor_version_upgrade")
    resource.Attributes.auto_minor_version_upgrade == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "MQ Broker minor version updates are activated.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "MQ Broker minor version updates must be activated.",
                "snippet": block }
} 
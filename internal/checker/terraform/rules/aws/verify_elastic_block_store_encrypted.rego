# METADATA
# title: "Make sure that all data stored in the Elastic Block Store of the instance or the Launch Configuration is encrypted in a secure manner."
# description: "It helps to prevent unauthorized access, data leakage, and potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration#root_block_device
# custom:
#   id: CB_TFAWS_007
#   severity: HIGH
package lib.terraform.CB_TFAWS_007

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_instance", "aws_launch_configuration"]
	label in supportedresource
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
    block.Type == "root_block_device"
    block.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'root_block_device' should is set properly.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "'root_block_device' should be set to true.",
                "snippet": block }
}
# METADATA
# title: "Verify that EC2 instance should not have public IP"
# description: "By not assigning a public IP to the EC2 instance, we ensure that its resources are not directly accessible from the internet, enhancing security and reducing the risk of unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#associate_public_ip_address
# custom:
#   id: CB_TFAWS_095
#   severity: HIGH
package lib.terraform.CB_TFAWS_095

import rego.v1

supportedresources := ["aws_instance", "aws_launch_template"]

isvalid(block, resource) if {
	block.Type == "resource"
	some label in block.Labels
	label == resource
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
	isvalid(resource, "aws_instance")
	has_associate_public_ip_address(resource.Attributes, "associate_public_ip_address")
}

pass contains resource if {
	some resource in input
	isvalid(resource, "aws_launch_template")
	has_network_interfaces(resource.Blocks)
}

has_network_interfaces(blocks) := result if {
	some block in blocks
	block.Type == "network_interfaces"
	result := has_associate_public_ip_address(block.Attributes, "associate_public_ip_address")
} else := result if {
	result := true
}

has_associate_public_ip_address(key, value) := result if {
	key[value] == false
	result := true
} else := result if {
	key[value] == true
	result := false
} else := result if {
	result := true
}

fail contains block if {
	some block in input
	some supported in supportedresources
	isvalid(block, supported)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_instance' or 'aws_launch_template' for 'associate_public_ip_address' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_instance' or 'aws_launch_template' for 'associate_public_ip_address' should be set.",
		"snippet": block,
	}
}
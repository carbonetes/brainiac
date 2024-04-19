# METADATA
# title: "Verify vpx subnets are not exposed"
# description: "This policy is ensures that it enforce network security best practices, ensuring that subnets are properly configured to limit exposure to the internet and mitigate security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_vpx
# custom:
#   id: CB_TFIBM_061
#   severity: HIGH
package lib.terraform.CB_TFIBM_061

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lb_vpx", "test_vpx"]
	label in supported_resource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid(url) if {
	startswith(url, "0.0.0.0/")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    not is_valid(attribute.public_subnet)
    not is_valid(attribute.private_subnet)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Subnets are not exposed",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Subnets are exposed",
		"snippet": block,
	}
}
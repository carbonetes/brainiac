# METADATA
# title: "Verify vpx supported versions are set"
# description: "This policy ensures that the proper version is selected. By enforcing this requirement, it helps maintain consistency and compatibility within the environment. Compliance with this policy ensures that all systems or components are configured with the specified version, reducing the likelihood of compatibility issues and ensuring smooth operation."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lb_vpx
# custom:
#   id: CB_TFIBM_062
#   severity: LOW
package lib.terraform.CB_TFIBM_062

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

pass contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
	value := ["10.1", "10.5", "11.0", "11.1", "12.1"]
    attribute.version in value
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "VPX support this version",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "VPX does not support this version",
		"snippet": block,
	}
}
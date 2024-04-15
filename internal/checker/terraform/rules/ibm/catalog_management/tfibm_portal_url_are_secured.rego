# METADATA
# title: "Verify URL on portal are secure"
# description: "This policy mandates that all URLs utilized within the system adhere to stringent security standards, particularly ensuring they utilize secure protocols such as HTTPS. By enforcing this measure, the policy aims to mitigate the risk of data breaches, unauthorized access, and other security threats that may arise from insecure communication channels"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_object
# custom:
#   id: CB_TFIBM_008
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_009

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_object", "cm_object"]
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
	startswith(url, "https://")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "publish"
	attribute := block.Attributes
	is_valid(attribute.portal_url)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Portal URLs is secure",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Portal URLs is not secure",
		"snippet": block,
	}
}
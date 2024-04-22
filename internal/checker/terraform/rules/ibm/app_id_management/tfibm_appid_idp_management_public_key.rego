# METADATA
# title: "Verify public key in IBM AppID Management"
# description: "This policy verifies the presence of the 'public_key' attribute in IBM AppID management resources, ensuring proper authentication and access control."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_custom
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_facebook
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_google
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_saml
# custom:
#   id: CB_TFIBM_076
#   severity: HIGH
package lib.terraform.CB_TFIBM_076

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["ibm_appid_idp_custom", "ibm_appid_idp_facebook", "ibm_appid_idp_google", "ibm_appid_idp_saml"]
	label in supported_resources
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	lacksPublicKey(resource)
}

lacksPublicKey(block) if {
	not block.Attributes.public_key
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID Management resource has a public key.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID Management resource lacks a public key.",
		"snippet": block,
	}
}

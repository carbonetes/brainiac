# METADATA
# title: "Verify Rancher OpenLDAP TLS Configuration"
# description: "This policy ensures that the Rancher OpenLDAP configuration with TLS enabled has a valid CA certificate."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_openldap
# custom:
#   id: CB_TFRAN_027
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_027

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_openldap" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.tls != false
	block.Attributes.certificate != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher OpenLDAP TLS configuration has a valid CA certificate.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher OpenLDAP TLS configuration is enabled but has an invalid or missing CA certificate. Provide a valid CA certificate or disable TLS.",
		"snippet": block,
	}
}

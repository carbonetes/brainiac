# METADATA
# title: "Verify load balancer front-end protocol is HTTPS"
# description: "This policy ensures that load balancers use HTTPS for the front-end protocol and require valid TLS certificate IDs. By enforcing these settings, it enhances data security and reduces the risk of unauthorized access or interception. Compliance is crucial to prevent potential security vulnerabilities and service disruptions" 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/lbaas
# custom:
#   id: CB_TFIBM_074
#   severity: MEDIUM 
package lib.terraform.CB_TFIBM_074

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_lbaas", "lbaas"]
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
	some block in resource.Blocks
    attribute := block.Attributes
	"frontend_protocol" in object.keys(attribute)
	attribute.frontend_protocol == "HTTPS"
	attribute.tls_certificate_id != ""
	not regex.match(`[A-Z]+`, attribute.tls_certificate_id)
	not regex.match(`[a-z]+`, attribute.tls_certificate_id)
	not regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, attribute.tls_certificate_id)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Front end protocol is HTTPS",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Front end protocol is not HTTPS",
		"snippet": block,
	}
}
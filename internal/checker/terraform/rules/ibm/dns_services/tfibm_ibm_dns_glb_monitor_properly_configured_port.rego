# METADATA
# title: "Verify the port in IBM DNS GLB Monitor is properly configured"
# description: "This policy ensures that the 'port' attribute within the 'ibm_dns_glb_monitor' resource is properly configured based on the 'type' attribute. For TCP checks, port is required. For HTTP and HTTPS checks, port should only be defined when using a non-standard port."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/dns_glb_monitor
# custom:
#   id: CB_TFIBM_115
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_115

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_dns_glb_monitor" in block.Labels
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
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasImproperPortConfiguration(resource)
}

hasImproperPortConfiguration(block) if {
	block.Attributes.type == "TCP"
	not block.Attributes.port
}

hasImproperPortConfiguration(block) if {
	block.Attributes.type == "HTTP"
	block.Attributes.port != 80
}

hasImproperPortConfiguration(block) if {
	block.Attributes.type == "HTTPS"
	block.Attributes.port != 443
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM DNS GLB Monitor resource has a properly configured 'port'. No action required.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM DNS GLB Monitor resource has an improperly configured 'port'. Please ensure the 'port' is properly configured.",
		"snippet": block,
	}
}

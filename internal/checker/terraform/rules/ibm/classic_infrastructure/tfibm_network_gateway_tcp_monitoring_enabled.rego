# METADATA
# title: "Verify TCP monitoring for network gateway is enabled"
# description: "This policy ensures that TCP monitoring is active on the network gateway. TCP monitoring is crucial for maintaining network stability, security, and performance by detecting issues like connection failures or security breaches in real-time. Compliance ensures timely detection and resolution of network abnormalities or threats, preserving overall network integrity." 
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/network_gateway
# custom:
#   id: CB_TFIBM_077
#   severity: MEDIUM 
package lib.terraform.CB_TFIBM_077

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_network_gateway", "gateway"]
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
	"tcp_monitoring" in object.keys(attribute)
    attribute.tcp_monitoring == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Tcp monitoring is enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Tcp monitoring is disabled",
		"snippet": block,
	}
}
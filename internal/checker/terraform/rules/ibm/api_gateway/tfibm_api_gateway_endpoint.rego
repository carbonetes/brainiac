# METADATA
# title: "Verify endpoint is configured for subscriptions"
# description: "This policy verifies that the 'managed' attribute is set to true for the 'ibm_api_gateway_endpoint' resource, ensuring the endpoint is online. Endpoint subscriptions can only be added if the endpoint is online. Misconfiguration of the 'managed' attribute can lead to endpoint unavailability, subscription failure, increased debugging time, and potential security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/api_gateway_endpoint_subscription
# custom:
#   id: CB_TFIBM_002
#   severity: LOW
package lib.terraform.CB_TFIBM_002

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["ibm_api_gateway_endpoint", "ibm_api_gateway_endpoint_subscriptions"]
	label in supported_resources
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
	hasInvalidAttribute(resource)
}

hasInvalidAttribute(block) if {
	block.Attributes.managed == false
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM API Gateway Endpoint is configured and online, ready for endpoint subscriptions.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM API Gateway Endpoint configuration is not allowing it to be online. Endpoint subscriptions cannot be added until the endpoint is online.",
        "snippet": block,
    }
}
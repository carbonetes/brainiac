# METADATA
# title: "Verify the api key type is supported"
# description: "This policy checks if the IBM App Gateway Endpoint resource has a supported type. The supported types are share, unshare, manage, and unmanage. If the api key type is not supported it can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/api_gateway_endpoint_subscription
# custom:
#   id: CB_TFIBM_087
#   severity: LOW
package lib.terraform.CB_TFIBM_087

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_api_gateway_endpoint_subscription" in block.Labels
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
	hasNotSupportedType(resource)
}

hasNotSupportedType(block) if {
    supported_types := ["external", "bluemix"]
    not block.Attributes.type in supported_types
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Gateway Endpoint Subscriptions resource has an api key supported type. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Gateway Endpoint resource has an api key unsupported type. Please update the api key type.",
        "snippet": block,
    }
}

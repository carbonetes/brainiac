# METADATA
# title: "Verify Service Endpoints should not be public"
# description: "This policy ensures that service endpoints are correctly configured as private, thereby facilitating accessibility to the Cloudant service from external sources while also ensuring appropriate network access controls are in place to mitigate potential risks associated with unauthorized access or exposure to the public internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant
# custom:
#   id: CB_TFIBM_056
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_056
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_cloudant"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
    some block in input
    isvalid(block)
    not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    res := resource.Attributes
    res.service_endpoints == "public"
}

passed contains result if {
	some block in pass
	result := {
		"message": "Service Endpoints is private.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Service Endpoints is not private.",
		"snippet": block,
	}
}

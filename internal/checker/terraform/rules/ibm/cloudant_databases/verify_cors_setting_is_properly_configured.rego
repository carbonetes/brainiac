# METADATA
# title: "Verify CORS setting is properly configured"
# description: "This policy checks and confirms CORS configuration settings to guarantee secure cross-origin resource sharing practices, promoting proper handling of cross-origin requests and mitigating potential security vulnerabilities associated with misconfigured CORS settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant
# custom:
#   id: CB_TFIBM_055
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_055
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
    some block in resource.Blocks
    block.Attributes.enable_cors == false
}

fail contains resource if {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Attributes.allow_credentials == true
}

passed contains result if {
	some block in pass
	result := {
		"message": "CORS is properly configured.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "CORS is not properly configured.",
		"snippet": block,
	}
}

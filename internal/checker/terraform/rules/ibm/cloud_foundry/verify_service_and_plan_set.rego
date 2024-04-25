# METADATA
# title: "Verify Service and Plan are set"
# description: "This policy evaluates the security of the designated service and plan for provisioning an IBM Cloud service instance, generating a violation message if the chosen service or plan is considered insecure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/service_instance
# custom:
#   id: CB_TFIBM_035
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_035
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_service_instance"
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
    res := block.Attributes
    "service" in object.keys(res)
    res.service != ""
    "plan" in object.keys(res)
    res.plan != ""
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Service and Plan are set",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Service and Plan must be set",
		"snippet": block,
	}
}

# METADATA
# title: "Verify guid is properly configured"
# description: "This policy evaluates the security of the process for obtaining the space GUID used in provisioning an IBM Cloud service instance, indicating a potential security concern if the space GUID does not start with a designated secure prefix."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/service_instance
# custom:
#   id: CB_TFIBM_042
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_042
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["ibm_service_instance", "ibm_service_key"]
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

pass contains block if {
    some block in input
    isvalid(block)
	res := block.Attributes
    "space_guid" in object.keys(res)
    res.space_guid != ""
}

pass contains block if {
    some block in input
    isvalid(block)
	res := block.Attributes
    "service_instance_guid" in object.keys(res)
    res.service_instance_guid != ""
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "GUID is properly configured.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "GUID is not configured.",
		"snippet": block,
	}
}

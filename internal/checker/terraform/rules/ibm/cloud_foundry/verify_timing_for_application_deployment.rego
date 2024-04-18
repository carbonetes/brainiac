# METADATA
# title: "Verify timing for application deployment is set"
# description: "This policy is primarily focused on ensuring that specific timing attributes necessary for application deployment are present in the Terraform configurations. These attributes, such as wait_timeout_minutes and wait_time_minutes, are crucial for managing the deployment process, potentially ensuring that sufficient time is allocated for deployment tasks to complete or for handling any potential delays during deployment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app
# custom:
#   id: CB_TFIBM_018
#   severity: LOW
package lib.terraform.CB_TFIBM_018
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_app"
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

fail contains block if {
	some block in input
	isvalid(block)
	block.Attributes.wait_time_minutes != "20"
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Attributes.wait_timeout_minutes != "90"
}

passed contains result if {
	some block in pass
	result := {
		"message": "Application Deployment timing is set",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Application Deployment timing is not set",
		"snippet": block,
	}
}
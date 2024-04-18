# METADATA
# title: "Verify sensitive data is not disclosed"
# description: "This policy is designed to verify that sensitive data, such as organization-specific identifiers or private keys, is not exposed within Terraform configurations, mitigating potential security risks associated with unauthorized access or exposure of confidential information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_domain_private
# custom:
#   id: CB_TFIBM_020
#   severity: HIGH
package lib.terraform.CB_TFIBM_020
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_app_domain_private"
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
	sensitive_data:= block.Attributes
	"org_guid" in object.keys(sensitive_data)
	sensitive_data.org_guid != ""
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Sensitive data is not exposed.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Sensitive data is exposed.",
		"snippet": block,
	}
}

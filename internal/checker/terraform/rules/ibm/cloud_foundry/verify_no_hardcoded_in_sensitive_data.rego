# METADATA
# title: "Verify sensitive data is not hardcoded"
# description: "This policy ensures that sensitive data is not hardcoded in the Terraform configuration for IBM Cloud shared domains."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_domain_shared
# custom:
#   id: CB_TFIBM_027
#   severity: HIGH
package lib.terraform.CB_TFIBM_027
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_app_domain_shared"
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
	pattern := ".*[!@#$%^&*()-=+{}\\[\\]:;\"'<>,.?/\\\\|].*"
	res := resource.Attributes
	"router_group_guid" in object.keys(res)
	sensitive_data := res.router_group_guid
	regex.match(pattern, sensitive_data)
}

passed contains result if {
	some block in pass
	result := {
		"message": "Sensitive data do not have hardcoded secrets.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Sensitive data have hardcoded secrets.",
		"snippet": block,
	}
}

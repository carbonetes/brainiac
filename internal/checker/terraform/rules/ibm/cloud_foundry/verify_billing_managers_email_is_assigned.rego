# METADATA
# title: "Verify emails for Billing Managers role is assigned"
# description: "This policy ensures that email addresses are correctly assigned to fulfill the Billing Manager role within the IBM Cloud organization, promoting effective access control and compliance measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/org
# custom:
#   id: CB_TFIBM_032
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_032
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_org"
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
    "billing_managers" in object.keys(res)
    count(res.billing_managers) == 0
}

fail contains resource if {
	some resource in input
    isvalid(resource)
    res := resource.Attributes
    some billing_managers in res.billing_managers
    billing_managers == ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Emails for billing manager role is assigned.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Emails for billing manager role is not assigned",
		"snippet": block,
	}
}

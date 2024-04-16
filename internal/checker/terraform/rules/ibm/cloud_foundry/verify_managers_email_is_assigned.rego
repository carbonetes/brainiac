# METADATA
# title: "Verify emails for Managers role is assigned"
# description: "This policy ensures that email addresses are appropriately assigned to fulfill the Managers role within the IBM Cloud organization, ensuring effective access control and adherence to organizational security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/org
# custom:
#   id: CB_TFIBM_033
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_033
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
    "managers" in object.keys(res)
    count(res.managers) == 0
}

fail contains resource if {
	some resource in input
    isvalid(resource)
    res := resource.Attributes
    some managers in res.managers
    managers == ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Emails for managers role is assigned.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Emails for managers role is not assigned",
		"snippet": block,
	}
}

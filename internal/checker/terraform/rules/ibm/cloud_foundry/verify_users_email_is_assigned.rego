# METADATA
# title: "Verify emails for Users role is assigned"
# description: "This policy verifies that email addresses are correctly assigned to fulfill the Users role within the IBM Cloud organization, maintaining robust access control and compliance standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/org
# custom:
#   id: CB_TFIBM_034
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_034
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
    "users" in object.keys(res)
    count(res.users) == 0
}

fail contains resource if {
	some resource in input
    isvalid(resource)
    res := resource.Attributes
    some users in res.users
    users == ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "Emails for users role is assigned.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Emails for users role is not assigned",
		"snippet": block,
	}
}

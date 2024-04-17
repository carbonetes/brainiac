	# METADATA
	# title: "Verify authorization is set in auditors role"
	# description: "This policy ensures that email addresses are properly assigned to fulfill the Auditor role within the IBM Cloud organization, promoting robust access control and compliance with security measures."
	# scope: package
	# related_resources:
	# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/org
	# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/space
	# custom:
	#   id: CB_TFIBM_028
	#   severity: MEDIUM
	package lib.terraform.CB_TFIBM_028
	import rego.v1

	isvalid(block) if {
		block.Type == "resource"
		some label in block.Labels
		supported_resources := ["ibm_org", "ibm_space"]
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
		not fail[block]
	}

	fail contains resource if {
		some resource in input
		isvalid(resource)
		res := resource.Attributes
		"auditors" in object.keys(res)
		count(res.auditors) == 0
	}

	fail contains resource if {
		some resource in input
		isvalid(resource)
		res := resource.Attributes
		some auditor in res.auditors
		auditor == ""
	}

	passed contains result if {
		some block in pass
		result := {
			"message": "Emails for auditor role is assigned.",
			"snippet": block
		}
	}

	failed contains result if {
		some block in fail
		result := {
			"message": "Emails for auditor role is not assigned",
			"snippet": block,
		}
	}

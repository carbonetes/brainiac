# METADATA
# title: "Verify Rancher2 Pod Security Policy Template Configuration"
# description: "This policy ensures validation of Rancher2 Pod Security Policy Template Configuration, in line with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/4.0.0/docs/resources/pod_security_policy_template
# custom:
#   id: CB_TFRAN_092
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_092

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_pod_security_policy_template" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation of Rancher2 Pod Security Policy Template Configuration, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Pod Security Policy Template Configuration validation. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}

# METADATA
# title: "Verify Rancher2 Cluster V2 Pod Security Admission Configuration Template"
# description: "Policy to verify Rancher2 Cluster V2 Pod Security Admission Configuration Template, ensuring 'default_pod_security_admission_configuration_template_name' is provided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_v2
# custom:
#   id: CB_TFRAN_190
#   severity: LOW
package lib.terraform.CB_TFRAN_190

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_v2" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	config := [
		"rancher-restricted",
		"rancher-privileged",
	]
	not block.Attributes.default_pod_security_admission_configuration_template_name in config
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster V2 Pod Security Admission Configuration Template has been successfully validated with the specified settings.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Cluster V2 Pod Security Admission Configuration Template. Ensure that 'default_pod_security_admission_configuration_template_name' is provided.",
		"snippet": block,
	}
}

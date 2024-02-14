# METADATA
# title: "Verify Rancher2 Etcd Backup Configuration"
# description: "Policy to verify Rancher2 Etcd Backup configuration for compliance with defined standards and parameters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/etcd_backup
# custom:
#   id: CB_TFRAN_079
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_079

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_etcd_backup" in block.Labels
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
	block.Attributes.cluster_id != ""
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
		"message": "Rancher2 Etcd Backup configuration successfully verified, meeting all defined standards and parameters",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Etcd Backup configuration detected. The 'cluster_id' and 'name' fields cannot be empty. Please provide valid string values to comply with configuration requirements.",
		"snippet": block,
	}
}

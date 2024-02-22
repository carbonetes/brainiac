# METADATA
# title: "Verify Backup Config for Rancher2 Etcd Backup"
# description: "Policy to verify that Rancher2 Etcd Backup configuration includes Backup Config."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/etcd_backup
# custom:
#   id: CB_TFRAN_123
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_123

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

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	not innerblock.Type == "backup_config"
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "backup_config"
	"enabled" in object.keys(innerblock.Attributes)
	innerblock.Attributes.enabled != true
	count(block.Blocks) == 1
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Etcd Backup configuration successfully validated with Backup Config included.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Etcd Backup configuration. Ensure that 'backup_config' is included and specified within the configuration.",
		"snippet": block,
	}
}

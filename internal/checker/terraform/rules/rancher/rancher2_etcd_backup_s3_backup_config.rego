# METADATA
# title: "Verify S3 Backup Config for Rancher2 Etcd Backup"
# description: "Policy to verify that Rancher2 Etcd Backup configuration includes S3 Backup Config."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/etcd_backup
# custom:
#   id: CB_TFRAN_124
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_124

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
    not s3_backup_config(block)
}

fail[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
	some innerblock in block.Blocks
	innerblock.Type == "backup_config"
    count(innerblock.Blocks) == 1
	some innerblock2 in innerblock.Blocks
	not innerblock2.Type == "s3_backup_config"
}

s3_backup_config(block) {
	some innerblock in block.Blocks
	innerblock.Type == "backup_config"
	some innerblock2 in innerblock.Blocks
	innerblock2.Type == "s3_backup_config"
    innerblock2.Attributes.bucket_name != ""
    innerblock2.Attributes.endpoint != ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Etcd Backup configuration successfully validated with S3 Backup Config included.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Etcd Backup configuration. Ensure that 's3_backup_config' is included and specified within the configuration.",
		"snippet": block,
	}
}

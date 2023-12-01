# METADATA
# title: "Verify RDS Instance Auto-Upgrades for Minor Versions"
# description: "This policy checks whether Amazon RDS (Relational Database Service) instances are configured to automatically upgrade to minor versions. Enabling automatic upgrades ensures that instances stay up-to-date with the latest security patches and improvements."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_021
#   severity: LOW
package lib.terraform.CB_TFALI_021

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_db_instance" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.auto_upgrade_minor_version == "Auto"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RDS instance is configured to auto-upgrade for minor versions, ensuring continuous improvement and security updates.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RDS instance does not have auto-upgrades for minor versions enabled. Enable automatic upgrades to benefit from the latest security patches and improvements.",
		"snippet": block,
	}
}

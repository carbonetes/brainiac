# METADATA
# title: "Verify Google Compute Instance Encryption with Customer Supplied Encryption Keys (CSEK) for Critical VM Disks"
# description: "This policy ensures that disks for critical Virtual Machines (VMs) are encrypted using Customer Supplied Encryption Keys (CSEK). CSEK provides an added layer of security for sensitive data."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_080
#   severity: HIGH
package lib.terraform.CB_TFGCP_080

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_compute_instance" in block.Labels
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
	some block in resource.Blocks
	block.Type == "disk_encryption_key"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "boot_disk"
	some innerblock in block.Blocks
	innerblock.Type == "disk_encryption_key_raw"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "boot_disk"
	some innerblock in block.Blocks
	innerblock.Type == "disk_encryption_key"
	innerblock.Attributes.disk_encryption_key_raw != null
	innerblock.Attributes.kms_key_self_link != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Disks for critical VMs are encrypted with Customer Supplied Encryption Keys (CSEK), ensuring enhanced data protection.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption with Customer Supplied Encryption Keys (CSEK) is not applied to disks for one or more critical VMs, posing a potential security risk to sensitive data.",
		"snippet": block,
	}
}

# METADATA
# title: "Verify that the PostgreSQL server has geo-redundant backups enabled"
# description: "Ensure that the PostgreSQL server is configured to enable geo-redundant backups. This setting enhances data protection by creating redundant backup copies in geographically separate locations, reducing the risk of data loss in case of a disaster"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_090
#   severity: LOW
package lib.terraform.CB_TFAZR_090

import future.keywords.in

supportedResources := ["azurerm_postgresql_server"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	resource.Attributes.geo_redundant_backup_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Geo-redundant backups are enabled for the PostgreSQL server.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Geo-redundant backups are not enabled for the PostgreSQL server.",
		"snippet": block,
    }
}

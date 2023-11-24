# METADATA
# title: "Verify GCP PostgreSQL Database has pgAudit Enabled"
# description: "This policy ensures that pgAudit is enabled for your Google Cloud Platform (GCP) PostgreSQL database. Enabling pgAudit enhances security by providing detailed auditing and monitoring capabilities."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_125
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_125

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_sql_database_instance" in block.Labels
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
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "settings"
    some innerblock in block.Blocks
    innerblock.Type == "database_flags"
	innerblock.Attributes.name == "cloudsql.enable_pgaudit"
    innerblock.Attributes.value != "on"
}

passed[result] {
	some block in pass
	result := {
		"message": "pgAudit is successfully enabled for the GCP PostgreSQL database, enhancing security through comprehensive auditing.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "pgAudit is not enabled for the GCP PostgreSQL database. Enable pgAudit for enhanced security through detailed auditing and monitoring.",
		"snippet": block,
	}
}

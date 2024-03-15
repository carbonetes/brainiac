# METADATA
# title: "Verify that Azure Data Factory utilizes a Git repository for source code management"
# description: "Ensure that the PostgreSQL server is configured to enable geo-redundant backups. This setting enhances data protection by creating redundant backup copies in geographically separate locations, reducing the risk of data loss in case of a disaster"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory
# custom:
#   id: CB_TFAZR_093
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_093

import future.keywords.in

supportedResources := ["azurerm_data_factory"]

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
	some innerblock in resource.Blocks
	innerblock.Type == "github_configuration"
    innerblock.Attributes.repository_name != null
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some innerblock in resource.Blocks
	innerblock.Type == "vsts_configuration"
    innerblock.Attributes.repository_name != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Azure Data Factory is verified to use a Git repository for source control.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Azure Data Factory does not use a Git repository for source control as required.",
		"snippet": block,
    }
}

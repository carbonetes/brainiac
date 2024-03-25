# METADATA
# title: "Verify Azure Data Factory utilizes Git repository for source control"
# description: "This policy enables serverless data integration and transformation through Azure Data Factory. It allows configuring a Git repository with either Azure Repos or GitHub, leveraging Git's version control capabilities for streamlined change tracking and collaboration."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.datafactory/factories?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_061
#   severity: LOW
package lib.azurearm.CB_AZR_061
import future.keywords.in

resource := "Microsoft.DataFactory/factories"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "repoConfiguration" in object.keys(properties)
    repo := properties.repoConfiguration
    "type" in object.keys(repo)
    type := repo.type
    type != ""
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Data Factory is using Git repository",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Data Factory is not using Git repository",
		"snippet": block,
	}
}
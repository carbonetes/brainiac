# METADATA
# title: "Verify manage virtual networks for Azure Synapse workspaces are enabled"
# description: "This policy promotes security and efficiency within Azure Synapse Workspaces by enabling managed virtual networks. Through this approach, access control, network security rules, and routing configurations are managed, enhancing data and workload isolation while optimizing performance by reducing network latency and traffic."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.synapse/workspaces?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_046
#   severity: LOW
package lib.azurearm.CB_AZR_046
import future.keywords.in

resource := "Microsoft.Synapse/workspaces"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "managedVirtualNetwork" in object.keys(properties)
    properties.managedVirtualNetwork != "default"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Synapse workspaces enables managed virtual networks",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Synapse workspaces not enabled managed virtual networks",
		"snippet": block,
	}
}
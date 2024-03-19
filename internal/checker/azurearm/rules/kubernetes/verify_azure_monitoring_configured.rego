# METADATA
# title: "Verify Azure monitoring for AKS logging is configured"
# description: "This policy ensures that Azure Monitoring gathers crucial telemetry data from AKS, such as memory and processor metrics for controllers, nodes, and container logs. Accessible through Azure Log Analytics for the AKS cluster and Azure Monitor instance, it's recommended to store these metrics for robust real-time and post-mortem analysis of AKS cluster behaviors."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_004
#   severity: MEDIUM
package lib.azurearm.CB_AZR_004
import future.keywords.in

resource := "Microsoft.ContainerService/managedClusters"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
    resource.apiVersion != "2017-08-31"
    "apiVersion" in object.keys(resource)
    properties := resource.properties
    "addonProfiles" in object.keys(properties)
    camelcase := properties.addonProfiles
	camelcase.omsagent.enabled == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS logging to Azure Monitoring is Configured",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS logging to Azure Monitoring is not Configured",
		"snippet": block,
	}
}
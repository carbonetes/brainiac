# METADATA
# title: "Verify Network Policy for AKS are configured"
# description: "This policy offers two options for network policy implementation in AKS: Azure Network Policies and Calico Network Policies. Both utilize Linux IPTables to enforce specified policies by translating them into sets of allowed and disallowed IP pairs. The principle of least privilege should guide the flow of traffic between pods within the cluster. It is recommended to select a preferred network policy framework and enforce granular usage-based policies on the application's architecture and business logic."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_007
#   severity: LOW
package lib.azurearm.CB_AZR_007
import future.keywords.in

resource := "Microsoft.ContainerService/managedClusters"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    apiversion := resource.apiVersion
    apiversion != "2017-08-31"
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    not properties == ""
    authorized := properties.networkProfile
    "networkProfile" in properties
    "networkPolicy" in authorized
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS cluster has Network Policy configured",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS cluster have no Network Policy configured",
		"snippet": block,
	}
}

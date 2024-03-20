# METADATA
# title: "Verify Kubernetes Dashboard are disabled"
# description: "This policy enables disabling the Kubernetes dashboard on an AKS cluster through the Azure Terraform provider. The dashboard is treated as an AKS add-on, similar to other features like Azure Monitor for containers integration or AKS virtual nodes. By default, the dashboard add-on is inactive for new clusters on Kubernetes 1.18 or later."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_008
#   severity: LOW
package lib.azurearm.CB_AZR_008
import future.keywords.in

resource := "Microsoft.ContainerService/managedClusters"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    some resource in input.resources
    properties := resource.properties
    properties != ""
    apiversion := resource.apiVersion
    apiversion != "2017-08-31"
    apiversion != ""
    "addonProfiles" in object.keys(properties)
    authorized := properties.addonProfiles
    "KubeDashboard" in object.keys(authorized)
    dashboard := authorized.KubeDashboard
    dashboard.enabled != true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Kubernetes Dashboard is disabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kubernetes Dashboard is not disabled",
		"snippet": block,
	}
}

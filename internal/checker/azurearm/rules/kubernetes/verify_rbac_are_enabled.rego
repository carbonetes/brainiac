# METADATA
# title: "Verify RBAC on AKS clusters are enabled"
# description: "This policy enables Azure Kubernetes Service (AKS) to integrate with Azure Active Directory (AD) and utilize Kubernetes Role-based Access Control (RBAC). With RBAC roles define permissions within AKS clusters allowing assignment to users or groups within specified scopes. By logging in to AKS with Azure AD tokens and configuring Kubernetes RBAC access to cluster resources is restricted based on user identity or group membership."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.containerservice/managedclusters?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_005
#   severity: HIGH
package lib.azurearm.CB_AZR_005
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
   	rbac := properties.enableRBAC
  	lower(rbac) == "true"
}


fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "RBAC on AKS clusters is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RBAC on AKS clusters is not enabled",
		"snippet": block,
	}
}

# METADATA
# title: "Verify Firewall rules settings on Key vault are allowed"
# description: "This policy enhances security by blocking unauthorized traffic from accessing your Key Vault. It ensures that only permitted networks can connect by configuring the firewall with bypass=AzureServices and default_action=deny."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_063
#   severity: MEDIUM
package lib.azurearm.CB_AZR_063
import future.keywords.in

resource := "Microsoft.KeyVault/vaults"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "networkAcls" in object.keys(properties)
    network := properties.networkAcls
    "defaultAction" in object.keys(network)
    action := network.defaultAction
    action != "Deny"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Key vault does allow firewall rules settings",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key vault  disallow firewall rules settings",
		"snippet": block,
	}
}
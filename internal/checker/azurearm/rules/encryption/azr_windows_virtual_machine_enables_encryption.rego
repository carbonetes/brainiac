# METADATA
# title: "Verify Windows VM enables encryption"
# description: "This policy ensures that enabling encryption for your Azure Windows virtual machine (VM) enhances its security and safeguards data integrity. Encryption ensures that data is encoded, making it accessible only to authorized users."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachinescalesets?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_075
#   severity: LOW
package lib.azurearm.CB_AZR_075

import future.keywords.in

resource := "Microsoft.Compute/virtualMachines"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.securityProfile
	properties.encryptionAtHost == true
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.securityProfile
	lower(properties.encryptionAtHost) == "true"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Windows Virtual Machine encryption is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Windows Virtual Machine encryption is not enabled.",
		"snippet": block,
	}
}

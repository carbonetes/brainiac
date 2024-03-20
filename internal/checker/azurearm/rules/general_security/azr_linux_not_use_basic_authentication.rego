# METADATA
# title: "Verify Azure Linux scale set doesn't use basic authentication"
# description: "This policy advocates using SSH keys instead of basic authentication for accessing Linux scale sets. SSH keys offer enhanced security by requiring privileged users to possess the private key associated with the public key generated on these sets. Even if an attacker obtains the scale set's public key, they cannot gain shell access without the corresponding private key."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers/databases?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_044
#   severity: HIGH
package lib.azurearm.CB_AZR_044
import future.keywords.in

resource := "Microsoft.Compute/virtualMachineScaleSets"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
  	properties := resource.properties
    "virtualMachineProfile" in object.keys(properties)
    storage := properties.virtualMachineProfile
    "storageProfile" in object.keys(storage)
    image := storage.storageProfile
    "imageReference" in object.keys(image)
	pub := image.imageReference
    "publisher" in object.keys(pub)
    lower(pub.publisher) != "windows"
    os := storage.osProfile
    linux := os.linuxConfiguration
    disable := linux.disablePasswordAuthentication
    disable == true
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure linux does not use basic authentication",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure linux are using basic authentication",
		"snippet": block,
	}
}
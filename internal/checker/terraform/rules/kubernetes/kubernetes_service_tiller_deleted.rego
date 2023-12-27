# METADATA
# title: "Remove Tiller Service (Helm v2)"
# description: "This policy mandates the deletion of the Tiller service, which is associated with Helm v2. Removing Tiller enhances security by eliminating potential vulnerabilities associated with the older Helm version."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
# custom:
#   id: CB_TFK8S_032
#   severity: LOW
package lib.terraform.CB_TFK8S_032

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_service",
		"kubernetes_service_v1",
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some block in resource.Blocks
    block.Type == "metadata"
    block.Attributes.labels["app"] == "helm"
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some block in resource.Blocks
    block.Type == "metadata"
    block.Attributes.labels["name"] == "tiller"
}

fail[resource] {
    some resource in input
    isvalid(resource)
    some block in resource.Blocks
    block.Type == "spec"
    block.Attributes.selector["app"] == "tiller"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Tiller service (Helm v2) has been successfully removed, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Tiller service (Helm v2) is still active. It is recommended to delete Tiller for improved security, considering potential vulnerabilities associated with the older Helm version.",
		"snippet": block,
	}
}

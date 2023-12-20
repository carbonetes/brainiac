# METADATA
# title: "Verify Absence of Tiller (Helm v2) Deployment"
# description: "This policy ensures that Tiller, the server-side component of Helm v2, is not deployed. Tiller is responsible for managing Helm releases in Kubernetes clusters."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_019
#   severity: LOW
package lib.terraform.CB_TFK8S_019

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_deployment",
		"kubernetes_deployment_v1",
		"kubernetes_pod",
		"kubernetes_pod_v1",
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
	block.Type == "spec"
	some template_block in block.Blocks
	template_block.Type == "template"
	some spec_block in template_block.Blocks
	spec_block.Type == "spec"
	some container_block in spec_block.Blocks
	container_block.Type == "container"
	container_block.Attributes.image == "tiller"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "spec"
	some template_block in block.Blocks
	template_block.Type == "template"
	some metadata_block in template_block.Blocks
	metadata_block.Type == "metadata"
	metadata_block.Attributes.labels.app == "helm"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "spec"
	some template_block in block.Blocks
	template_block.Type == "template"
	some metadata_block in template_block.Blocks
	metadata_block.Type == "metadata"
	metadata_block.Attributes.labels.name == "tiller"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Tiller (Helm v2) is not deployed, enhancing the security of the Kubernetes cluster.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Tiller (Helm v2) is deployed. Consider upgrading to Helm v3 and uninstalling Tiller to improve Kubernetes security.",
		"snippet": block,
	}
}

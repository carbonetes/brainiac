# METADATA
# title: "Mandate the Use of Image Digests"
# description: "This policy requires images to use digests rather than tags. Utilizing digests ensures image integrity and traceability, as the digest is unique to the content of the image."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_031
#   severity: LOW
package lib.terraform.CB_TFK8S_031

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

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "spec"
	some spec in block.Blocks
	spec.Type == "template"
	some template in spec.Blocks
	template.Type == "spec"
	some container in template.Blocks
	container.Type == "container"
    contains(container.Attributes.image, "@")
} 

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Images are configured to use digests, enhancing security through content verification.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Images are still relying on tags instead of digests. It is recommended to adopt image digests for improved image integrity and traceability.",
		"snippet": block,
	}
}

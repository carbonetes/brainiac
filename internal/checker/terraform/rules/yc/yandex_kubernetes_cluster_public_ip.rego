# METADATA
# title: "Restrict Public IP Address in Kubernetes Cluster"
# description: "This policy ensures that a Kubernetes cluster does not have a public IP address assigned, enhancing security by reducing exposure to external threats."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFYC_005
#   severity: LOW
package lib.terraform.CB_TFYC_005

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_cluster" in block.Labels
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
	block.Type == "master"
	block.Attributes.public_ip == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster does not have a public IP address, aligning with security best practices.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Kubernetes cluster has a public IP address assigned. It is recommended to restrict public access for improved security posture.",
		"snippet": block,
	}
}

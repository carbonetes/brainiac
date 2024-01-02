# METADATA
# title: "Verify Absence of Exposed Docker Daemon Socket to Containers"
# description: "This policy ensures that the Docker daemon socket is not exposed to containers. Exposing the Docker daemon socket poses a significant security risk, allowing potential unauthorized access and control over the host system."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_009
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_009

import future.keywords.in

isvalid(resource) {
	supported_resources := [
        "kubernetes_daemon_set_v1",
        "kubernetes_daemonset",
        "kubernetes_deployment",
        "kubernetes_deployment_v1",
        "kubernetes_pod",
        "kubernetes_pod_v1"
	]
	resource.Type == "resource"
	some label in resource.Labels
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
    some spec_template_block in block.Blocks
    spec_template_block.Type == "template"
    some template_spec_block in spec_template_block.Blocks
    template_spec_block.Type == "spec"
    some spec_volumes_block in template_spec_block.Blocks
    spec_volumes_block.Type == "volumes"
    some volumes_host_path_block in spec_volumes_block.Blocks
    volumes_host_path_block.Attributes.path == "/var/run/docker.sock"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Docker daemon socket is not exposed to containers, maintaining a secure container environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Exposing the Docker daemon socket to containers is detected, posing a severe security risk. Refrain from exposing the Docker daemon socket to enhance container security.",
		"snippet": block,
	}
}

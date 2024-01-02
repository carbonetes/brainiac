# METADATA
# title: "Avoid utilizing the default namespace"
# description: "Utilizing the default namespace is discouraged to assure proper Kubernetes cluster management and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_026
#   severity: LOW
package lib.terraform.CB_TFK8S_026

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_config_map",
		"kubernetes_config_map_v1",
		"kubernetes_cron_job",
		"kubernetes_cron_job_v1",
		"kubernetes_daemon_set_v1",
		"kubernetes_daemonset",
		"kubernetes_deployment",
		"kubernetes_deployment_v1",
		"kubernetes_ingress",
		"kubernetes_ingress_v1",
		"kubernetes_job",
		"kubernetes_job_v1",
		"kubernetes_pod",
		"kubernetes_pod_v1",
		"kubernetes_replication_controller",
		"kubernetes_replication_controller_v1",
		"kubernetes_role_binding",
		"kubernetes_role_binding_v1",
		"kubernetes_secret",
		"kubernetes_secret_v1",
		"kubernetes_service",
		"kubernetes_service_account",
		"kubernetes_service_account_v1",
		"kubernetes_service_v1",
		"kubernetes_stateful_set",
		"kubernetes_stateful_set_v1",
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

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "metadata"
	inner_block.Attributes.namespace != "default"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The default namespace is not utilized.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The default namespace must not be utilized.",
		"snippet": block,
	}
}

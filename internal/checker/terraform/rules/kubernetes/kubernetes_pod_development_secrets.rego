# METADATA
# title: "Prefer Secrets as Files Over Environment Variables"
# description: "This policy encourages the use of secrets as files rather than environment variables. Storing sensitive information, such as API keys or passwords, in files provides an additional layer of security compared to environment variables."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_023
#   severity: LOW
package lib.terraform.CB_TFK8S_023

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
	some template_block in block.Blocks
	template_block.Type == "template"
	some spec_block in template_block.Blocks
	spec_block.Type == "spec"
	some container_block in spec_block.Blocks
	container_block.Type == "container"
	some env_block in container_block.Blocks
	env_block.Type == "env"
	some value_from_block in env_block.Blocks
	value_from_block.Type == "value_from"
    some secret_key_ref_block in value_from_block.Blocks
  	secret_key_ref_block.Type == "secret_key_ref"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Secrets are appropriately stored as files, enhancing security by minimizing exposure to potential threats.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Secrets are configured as environment variables. Consider updating the configuration to store sensitive information in files for improved security.",
		"snippet": block,
	}
}

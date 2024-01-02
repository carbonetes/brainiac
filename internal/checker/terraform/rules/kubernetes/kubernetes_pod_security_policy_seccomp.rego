# METADATA
# title: "Verify Default Seccomp Profile for Containers"
# description: "This policy ensures that the default Seccomp profile for containers is set to either 'docker/default' or 'runtime/default.' Seccomp (Secure Computing Mode) is a security feature that restricts the system calls available to containers, enhancing their overall security."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_018
#   severity: LOW
package lib.terraform.CB_TFK8S_018

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"kubernetes_pod_security_policy" in block.Labels
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
	some metadata_block in resource.Blocks
	metadata_block.Type == "metadata"
    annotation_value := metadata_block.Attributes.annotations["seccomp.security.alpha.kubernetes.io/defaultProfileName"]
    some annotation in ["docker/default", "runtime/default"]
    contains(annotation_value, annotation)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The default Seccomp profile is correctly configured as 'docker/default' or 'runtime/default,' contributing to a secure container environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The default Seccomp profile is not set to an approved value. Update the Seccomp profile to 'docker/default' or 'runtime/default' to enhance container security.",
		"snippet": block,
	}
}
# METADATA
# title: "Aim to restrict the number of containers admitted with assigned capabilities"
# description: "restricting the amount of containers that are admitted with capabilities helps guarantee that few containers have lengthened capabilities above the default range."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-admission/
# custom:
#   id: CB_K8S_108
#   severity: LOW
package lib.kubernetes.CB_K8S_108

import data.lib.kubernetes

resource = kubernetes.resource


check {
    container := input.spec.containers[_]
    kubernetes.has_attribute(container.securityContext.capabilities, "drop")
    drop := container.securityContext.capabilities.drop[_]
    regex.match(`(?i)\ball\b`, drop)
}


passed[result] {
	kubernetes.is_psp
	check
	result := {"message":  sprintf("%s '%s' root privileges for container are dropped ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	kubernetes.is_psp
	not check
	result := {"message": sprintf("%s '%s' root privileges for container are not dropped ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

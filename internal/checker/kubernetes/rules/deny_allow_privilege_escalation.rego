# METADATA
# title: "Make certain that containers are not running with AllowPrivilegeEscalation"
# description: "AllowPrivilegeEscalation should ideally be set to False in order to prevent RunAsUser instructions from circumventing their current sets of permissions."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/
# custom:
#   id: CB_K8S_104
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_104

import data.lib.kubernetes

resource = kubernetes.resource


check[container] {
    kubernetes.is_psp
    container := kubernetes.containers[_]
    kubernetes.has_attribute(container.securityContext, "allowPrivilegeEscalation")
    container.securityContext.allowPrivilegeEscalation == false
}

passed[result] {
	container := check[_]
	result := {"message":  sprintf("%s '%s' 'allowPrivilegeEscalation' is not set to true ", [kubernetes.kind, kubernetes.name]),
			"snippet" : container
	}
}
failed[result] {
	kubernetes.is_psp
	container := kubernetes.containers[_]
    not check[container]
	result := {"message": sprintf("%s '%s' 'allowPrivilegeEscalation' is set to true ", [kubernetes.kind, kubernetes.name]),
				"snippet" : container
	}
}

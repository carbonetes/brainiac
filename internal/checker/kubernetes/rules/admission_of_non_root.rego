# METADATA
# title: "Minimize the admission of root user"
# description: "'runAsNonRoot' force the currently running image to run as a non-root user to guarantee minimum privileges."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/
# custom:
#   id: CB_K8S_021
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_021

import data.lib.kubernetes


resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

nonRootSpecSecurityContext {
	pods := kubernetes.podTemplates[_]
	not pods.spec.securityContext.runAsNonRoot
}

rootContainers[container] {
	container := kubernetes.containers[_]
	not nonRootContainers[container]
}

nonRootContainers[container] {
	container := kubernetes.containers[_]
	container.securityContext.runAsNonRoot == true
}


passed[result] {
	isValid
	container := nonRootContainers[_]
	result := {"message": sprintf("Containers of %s '%s' 'securityContext.runAsNonRoot' is enabled", [kubernetes.kind, kubernetes.name]),
				"snippet": container
	}
}

failed[result] {
	isValid
    nonRootSpecSecurityContext
	container := rootContainers[_]
	result := {"message": sprintf("Containers of %s '%s' should enabled 'securityContext.runAsNonRoot'", [kubernetes.kind, kubernetes.name]),
	 			"snippet" : container
	}
}

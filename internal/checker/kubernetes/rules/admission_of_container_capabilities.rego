# METADATA
# title: "Verify the admission of containers with added capability"
# description: "Generally, do not allow containers whose capabilities are allocated beyond the default set."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/policy/pod-security-policy/#capabilities
# custom:
#   id: CB_K8S_023
#   severity: LOW
package lib.kubernetes.CB_K8S_023

import data.lib.kubernetes


resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


checkContainersCapabilities {
	isValid
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext.capabilities, "add")
    nonDefaultCapabilities := container.securityContext.capabilities.add[_]
    count(nonDefaultCapabilities) > 0

}


passed[result] {
	isValid
	not checkContainersCapabilities
	result := sprintf("Containers of %s '%s' 'securityContext.capabilities' has default capabilities", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    checkContainersCapabilities
	result := sprintf("Containers of %s '%s''securityContext.capabilities' has implemented non default capabilities", [kubernetes.kind, kubernetes.name])
}

# METADATA
# title: "Admission of containers with capability is not minimized"
# description: "Limiting container admission with capacities ensures that only a small number of containers have extensive capacities outside the default range."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_041
#   severity: LOW
package lib.kubernetes.CB_K8S_041

import data.lib.kubernetes
import future.keywords.in


resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

check[capabilities]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext, "capabilities")
    capabilities := container.securityContext.capabilities
	capabilities.drop[_] == "ALL"

}

notLimited[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container.securityContext, "capabilities")
}

notLimited[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container, "securityContext")
}
notLimited[capabilities]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext, "capabilities")
    capabilities := container.securityContext.capabilities
	not check[capabilities]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.capabilities' have a drop 'ALL' capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

failed[result] {
	isValid
    res := notLimited[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.capabilities' should drop 'ALL' capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

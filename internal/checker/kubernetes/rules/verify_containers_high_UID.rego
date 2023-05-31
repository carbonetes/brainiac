# METADATA
# title: "Verify containers run with a high UID"
# description: "With a high UID number, a container is blocked from accessing host-based files even if it can access a host's filesystem."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_046
#   severity: LOW
package lib.kubernetes.CB_K8S_046

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

check[container]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext, "runAsUser")
   	container.securityContext.runAsUser >= 10000
}

userNotSet[container]{
	container := kubernetes.containers[_]
	not check[container]
}

userNotSet[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container, "securityContext")
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.runAsUser' is set with greater than or equal to 10000", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

failed[result] {
	isValid
    res := userNotSet[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.runAsUser' should set to greater than or equal to 10000", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

# METADATA
# title: "Should not run containers with allowPrivilegeEscalation"
# description: "The allowPrivilegeEscalation setting controls whether a process can gain more privileges than its parent process."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_016
#   severity: HIGH
package lib.kubernetes.CB_K8S_016

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersAllowPrivilegeEscalation[container] {
	isValid
	container := kubernetes.containers[_]
	container.securityContext.allowPrivilegeEscalation == false
}


getContainersNoAllowPrivilegeEscalation[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersAllowPrivilegeEscalation[container]
}

passed[result] {
	containers := getContainersAllowPrivilegeEscalation[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' is set with 'securityContext.allowPrivilegeEscalation' to false", [containers.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : containers
		 }
}

failed[result] {
	containers := getContainersNoAllowPrivilegeEscalation[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should not enabled 'securityContext.allowPrivilegeEscalation'", [containers.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : containers
		}
}

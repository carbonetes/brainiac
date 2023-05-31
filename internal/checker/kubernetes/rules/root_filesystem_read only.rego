# METADATA
# title: "The root filesystem does not read only."
# description: "A read-only root file system makes it possible to enforce an unchangeable infrastructure strategy."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_019
#   severity: LOW
package lib.kubernetes.CB_K8S_019

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getRootFileSystem[container] {
	isValid
	container := kubernetes.containers[_]
	container.securityContext.readOnlyRootFilesystem == true
}


getNoRootFileSystem[container] {
	isValid
	container := kubernetes.containers[_]
	not getRootFileSystem[container]
}

passed[result] {
	containers := getRootFileSystem[_]
	result := {"message" :sprintf("Container '%s' of %s '%s'is set with 'securityContext.readOnlyRootFilesystem'", [containers.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : containers
	}
}
failed[result] {
	containers := getNoRootFileSystem[_]
	result := { "message": sprintf("Container '%s' of %s '%s' should enabled 'securityContext.readOnlyRootFilesystem'", [containers.name, kubernetes.kind, kubernetes.name]),
				"snippet" : containers
	}
}

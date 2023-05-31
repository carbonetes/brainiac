# METADATA
# title: "Make sure the container is not privileged."
# description: "Executing a container with a privileged flag enables users to have critical access to the host's resources."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_012
#   severity: HIGH
package lib.kubernetes.CB_K8S_012

import data.lib.kubernetes

resource = kubernetes.resource


validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersPrivileged[container] {
	isValid
	container := kubernetes.containers[_]
	container.securityContext.privileged == true
}


getContainersNoPrivileged[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersPrivileged[container]
}

passed[result] {
	containers := getContainersNoPrivileged[_]
	result := {"message": sprintf("Container '%s' of %s '%s' not set with 'securityContext.privileged'", [containers.name, kubernetes.kind, kubernetes.name]),
				"snippet" : containers
			  }
}
failed[result] {
	containers := getContainersPrivileged[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should not enabled 'securityContext.privileged'", [containers.name, kubernetes.kind, kubernetes.name]),
				"snippet": containers
			  }
}

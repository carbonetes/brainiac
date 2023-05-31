# METADATA
# title: "Do not specify hostPort except when absolutely necessary."
# description: "When you bind a pod to a hostPort, it limits the number of places the pod can be scheduled, because each <hostIP, hostPort, protocol> combination must be unique."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/overview/
# custom:
#   id: CB_K8S_030
#   severity: LOW
package lib.kubernetes.CB_K8S_030

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersWithHostPorts[container] {
	isValid
    container := kubernetes.containers[_]
	kubernetes.has_attribute(container.ports[_], "hostPort")
}

getContainersNoHostPorts[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersWithHostPorts[container]
}

passed[result] {
	container := getContainersNoHostPorts[_]
	result := {"message": sprintf("Container '%s' of %s '%s' net set with 'hostPort'", [container.name, kubernetes.kind, kubernetes.name]),
				"snippet" : container 
			  }
}
failed[result] {
	container := getContainersWithHostPorts[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should not specify ports 'hostPort", [container.name, kubernetes.kind, kubernetes.name]),
				"snippet" : container
			  }
}

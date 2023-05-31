# METADATA
# title: "Memory requests should be specified"
# description: "Specifying a memory resource requests on your container can avoid applications to take up more resources than they should."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
# custom:
#   id: CB_K8S_006
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_006

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersMemory[container] {
	isValid
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.resources.requests, "memory")
}


getContainersNoMemory[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersMemory[container]
}

passed[result] {
	memoryRes := getContainersMemory[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' has 'resources.requests.memory'", [memoryRes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : memoryRes
			  }
}
failed[result] {
	memoryRes := getContainersNoMemory[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'resources.requests.memory'", [memoryRes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : memoryRes 
			  }
}

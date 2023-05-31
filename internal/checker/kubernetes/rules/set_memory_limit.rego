# METADATA
# title: "Memory limits should be specified"
# description: "Not setting a memory limit in the containers running in the node could exhaust all memory available."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
# custom:
#   id: CB_K8S_007
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_007

import data.lib.kubernetes

resource = kubernetes.resource


validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}
getContainersLimitMemory[container] {
	isValid
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.resources.limits, "memory")
}


getContainersNoLimitMemory[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersLimitMemory[container]
}

passed[result] {
	memoryRes := getContainersLimitMemory[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' has 'resources.limits.memory'", [memoryRes.name, kubernetes.kind, kubernetes.name]),
				"snippet": memoryRes
			  }
}
failed[result] {
	memoryRes := getContainersNoLimitMemory[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'resources.limits.memory'", [memoryRes.name, kubernetes.kind, kubernetes.name]),
				"snippet": memoryRes 
			  }
}

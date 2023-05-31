# METADATA
# title: "CPU limits should be set"
# description: "Not setting a CPU limit in the containers running in the node could exhaust all CPU available."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
# custom:
#   id: CB_K8S_003
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_003

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersLimitCPU[container] {
	isValid
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.resources.limits, "cpu")
}


getContainersNoLimitCPU[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersLimitCPU[container]
}

passed[result] {
	cpuRes := getContainersLimitCPU[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' has 'resources.limits.cpu'", [cpuRes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : cpuRes 
			  }
}
failed[result] {
	cpuRes := getContainersNoLimitCPU[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'resources.limits.cpu'", [cpuRes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : cpuRes 
			  }
}

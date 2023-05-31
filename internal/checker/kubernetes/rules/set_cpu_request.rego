# METADATA
# title: "CPU requests should be specified"
# description: "Specifying a cpu resource requests on your container can avoid applications to take up more resources than they should."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
# custom:
#   id: CB_K8S_002
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_002

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersCPU[container] {
	isValid
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.resources.requests, "cpu")
}


getContainersNoCPU[container] {
	isValid
	container := kubernetes.containers[_]
	not getContainersCPU[container]
}

passed[result] {
	cpuRes := getContainersCPU[_]
	result := {"message": sprintf("Container '%s' of %s '%s' has 'resources.requests.cpu'", [cpuRes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : cpuRes 
			  }
}
failed[result] {
	cpuRes := getContainersNoCPU[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'resources.requests.cpu'", [cpuRes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : cpuRes
			  }
}

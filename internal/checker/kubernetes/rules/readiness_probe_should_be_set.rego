# METADATA
# title: "Readiness Probe Should be set up"
# description: "This helps to avoid sending traffic to a container that is not yet ready to handle it, which can cause errors and slow down the application."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
# custom:
#   id: CB_K8S_099
#   severity: LOW
package lib.kubernetes.CB_K8S_099

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

not_job{
	not kubernetes.kind == "Job"
	not kubernetes.is_cronjob
}
getContainersReadiness[container] {
	not_job
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container, "readinessProbe")
}


getContainersNoReadiness[container] {
	not_job
	container := kubernetes.containers[_]
	not getContainersReadiness[container]
}

passed[result] {
	isValid
	res := getContainersReadiness[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' has 'readinessProbe'", [res.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res
			  }
}
failed[result] {
	isValid
	res := getContainersNoReadiness[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'readinessProbe'", [res.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res 
			  }
}

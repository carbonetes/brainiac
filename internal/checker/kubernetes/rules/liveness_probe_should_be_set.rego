# METADATA
# title: "Liveness Probe Should be set up"
# description: "By configuring a Liveness Probe, you can proactively monitor the health of your containers and take corrective action before problems become critical."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
# custom:
#   id: CB_K8S_097
#   severity: LOW
package lib.kubernetes.CB_K8S_097

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
getContainersLiveness[container] {
	not_job
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container, "livenessProbe")
}


getContainersNoLiveness[container] {
	not_job
	container := kubernetes.containers[_]
	not getContainersLiveness[container]
}

passed[result] {
	isValid
	res := getContainersLiveness[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' has 'livenessProbe'", [res.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res
			  }
}
failed[result] {
	isValid
	res := getContainersNoLiveness[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' should set 'livenessProbe'", [res.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res 
			  }
}

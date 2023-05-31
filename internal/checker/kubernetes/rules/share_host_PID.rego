# METADATA
# title: "Make sure containers do not share host process ID namespace"
# description: "If the host's PID namespace is shared with the container, it would basically allow processes within the container to see all of the processes on the host system."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/
# custom:
#   id: CB_K8S_013
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_013

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hostPIDs[host_pid] {
	pods := kubernetes.podTemplates[_]
	host_pid = pods.spec.hostPID
}
shareHostPIDEnabled {
	isValid
    hostPIDs[_] == true
}

passed[result] {
	isValid
	not shareHostPIDEnabled
	pods := kubernetes.podTemplates[_]
	 result := {"message" : sprintf("%s '%s' 'hostPID' is not enabled ", [kubernetes.kind, kubernetes.name]), 
	 			"snippet" : pods.spec 
			   }
 }
failed[result] {
	shareHostPIDEnabled
	pods := kubernetes.podTemplates[_]
	result := {"message" : sprintf("%s '%s' 'hostPID' is  enabled ", [kubernetes.kind, kubernetes.name]),
				"snippet" : pods.spec 
			  }
}

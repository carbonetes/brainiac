# METADATA
# title: "Containers must not share a host IPC namespace"
# description: "Not sharing IPC namespaces is helpful in ensuring isolation."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/
# custom:
#   id: CB_K8S_015
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_015

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hostIPCs[host_pid] {
	pods := kubernetes.podTemplates[_]
	host_pid = pods.spec.hostIPC
}
shareHostIPCEnabled {
	isValid
    hostIPCs[_] == true
}

passed[result] {
	isValid
	not shareHostIPCEnabled
	pods := kubernetes.podTemplates[_]
	 result := {"message" : sprintf("%s '%s' 'hostIPC' is not enabled ", [kubernetes.kind, kubernetes.name]),
	 			"snippet": pods.spec
			   }
}
failed[result] {
	shareHostIPCEnabled
	pods := kubernetes.podTemplates[_]
	result := {"message" :sprintf("%s '%s' 'hostIPC' is  enabled ", [kubernetes.kind, kubernetes.name]),
			   "snippet" : pods.spec
			   }
}

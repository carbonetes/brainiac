# METADATA
# title: "Containers must not share the host network namespace"
# description: "Not sharing the host’s network namespace Limit the options of an attacker to move privileges up from a container."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline
# custom:
#   id: CB_K8S_017
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_017

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}
hostNetwork[host_pid] {
	pods := kubernetes.podTemplates[_]
	host_pid = pods.spec.hostNetwork
}
shareHostNetworkenabled {
	isValid
    hostNetwork[_] == true
}

passed[result] {
	isValid
	not shareHostNetworkenabled
	pods := kubernetes.podTemplates[_]
	 result := {"message" : sprintf("%s '%s' 'hostNetwork' is not enabled ", [kubernetes.kind, kubernetes.name]),
	 			"snippet" : pods.spec 
			   }
}
failed[result] {
	shareHostNetworkenabled
	pods := kubernetes.podTemplates[_]
	result := {"message": sprintf("%s '%s' 'hostNetwork' is  enabled ", [kubernetes.kind, kubernetes.name]),
			   "snippet" : pods.spec 
			  }
}

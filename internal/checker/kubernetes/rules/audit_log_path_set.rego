# METADATA
# title: "There is no —audit-log-path parameter specified"
# description: "Set the selected audit log path and allow auditing on the Kubernetes API Server."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/#configure-logging-of-requests
# custom:
#   id: CB_K8S_079
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_079

import data.lib.kubernetes
import future.keywords.in 

resource = kubernetes.resource


default flag := "--audit-log-path"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand[container] {
    container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, flag)
}


passed[result] {
	isValid
	container := hasContainersCommand[_]
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set.", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": container}
}

failed[result] {
	isValid
    container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not hasContainersCommand[container]
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is invalid.", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": container }
}
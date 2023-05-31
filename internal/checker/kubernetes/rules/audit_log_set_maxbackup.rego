# METADATA
# title: "The --audit-log-maxbackup parameter is not configured correctly"
# description: "Keep 10 or as many old log files as necessary."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/debug-application-cluster/audit/#changing-the-log-max-backup-and-max-age
# custom:
#   id: CB_K8S_089
#   severity: LOW
package lib.kubernetes.CB_K8S_089

import data.lib.kubernetes
import future.keywords.in 

resource = kubernetes.resource


default flag := "--audit-log-maxbackup"
default argument := 10

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
	args := split(commands, "=")[1]
    to_number(args) >= argument
}


passed[result] {
	isValid
	container := hasContainersCommand[_]
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": container}
}

failed[result] {
	isValid
    container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not hasContainersCommand[container]
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s' or as appropriate.", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": container }
}




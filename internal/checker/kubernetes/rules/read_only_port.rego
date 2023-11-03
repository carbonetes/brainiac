# METADATA
# title: "Verify that the --read-only-port argument is set to 0"
# description: "This ensures that no unauthenticated access is provided to this read-only API that could access sensitive data from the cluster"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/
# custom:
#   id: CB_K8S_028
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_028

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--read-only-port"
default argument := "0"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasReadOnlyPort(container) {
    kubernetes.has_container_command(container, flag, argument)
}

getContainerCommand[container] {
    some index, command_index
    startswith(kubernetes.containers[index].command[command_index], flag)
    container := kubernetes.containers[index]
}

getContainerCommand[container] {
    some index, command_index
    startswith(kubernetes.containers[index].args[command_index], flag)
    container := kubernetes.containers[index]
}

passed[result] {
    isValid
	commands := kubernetes.containers_commands
    hasReadOnlyPort(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	commands := kubernetes.containers_commands
    not hasReadOnlyPort(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": {} }
}

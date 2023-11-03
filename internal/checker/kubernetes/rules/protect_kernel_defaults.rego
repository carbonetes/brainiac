# METADATA
# title: "Verify that the --protect-kernel-defaults argument is set to true"
# description: "This ensures that the kernel defaults are protected"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/#protect-kernel-defaults
# custom:
#   id: CB_K8S_039
#   severity: LOW
package lib.kubernetes.CB_K8S_039

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--protect-kernel-defaults"
default argument := "true"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasCommand(container) {
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
    hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	commands := kubernetes.containers_commands
    not hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": {} }
}

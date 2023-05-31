# METADATA
# title: "Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture"
# description: "Ensure that the --event-qps is set to 0 or a level that ensures appropriate event capture"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/
# custom:
#   id: CB_K8S_048
#   severity: LOW
package lib.kubernetes.CB_K8S_048

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--event-qps"
default argument := "5"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand[commands] {
    commands := kubernetes.containers_commands
    commands[_] == "kubelet"
    startswith(commands[_], flag)
}

has_container_command(key, flag, argument) {
	split({ r | r := key[_]; startswith(r, flag) }[_], "=")[1] > argument
}

hasCommand(container) {
    not has_container_command(container, flag, argument)
}

getContainerCommand[container] {
    startswith(kubernetes.containers[index].command[command_index], flag)
    container := kubernetes.containers[index]
}

passed[result] {
    isValid
	commands := hasContainersCommand[_]
    hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	commands := hasContainersCommand[_]
    not hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}
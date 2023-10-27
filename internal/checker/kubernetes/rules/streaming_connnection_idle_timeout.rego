# METADATA
# title: "Verify that the --streaming-connection-idle-timeout argument is set to 0"
# description: "This ensures that you are protected against Denial-of-Service attacks, inactive connections and running out of ephemeral ports"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/#options-40
# custom:
#   id: CB_K8S_038
#   severity: LOW
package lib.kubernetes.CB_K8S_038

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--streaming-connection-idle-timeout"
default argument := "0"

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
    not hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": {} }
}

failed[result] {
    isValid
	commands := kubernetes.containers_commands
    hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must not be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}

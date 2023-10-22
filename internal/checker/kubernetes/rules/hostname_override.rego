# METADATA
# title: "Verify that the --hostname-override argument is not set"
# description: "Changing the node hostnames could potentially break the TLS setup between the kubelet and the apiserver"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/#kubelet-command-line-arguments
# custom:
#   id: CB_K8S_043
#   severity: LOW
package lib.kubernetes.CB_K8S_043

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

default flag := "--hostname-override"
default hasContainersCommand := false

hasContainersCommand {
    commands := kubernetes.containers_commands
    commands[_] == "kubelet"
    startswith(commands[_], flag)
}

getContainerCommand[container] {
    some index, command_index
    startswith(kubernetes.containers[index].command[command_index], flag)
    container := kubernetes.containers[index]
}

passed[result] {
    isValid
	not hasContainersCommand
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is not set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": {} }
}

failed[result] {
    isValid
	hasContainersCommand
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must not be set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": getContainerCommand[_] }
}

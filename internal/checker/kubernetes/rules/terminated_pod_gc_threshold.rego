# METADATA
# title: "Verify that the --terminated-pod-gc-threshold is set appropriately"
# description: "Ensure that the --terminated-pod-gc-threshold is is set appropriately"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/
# custom:
#   id: CB_K8S_096
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_096

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--terminated-pod-gc-threshold"
default argument := "0"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand[commands] {
    commands := kubernetes.containers_commands
    commands[_] == "kube-controller-manager"
    startswith(commands[_], flag)
}

hasCommand(commands) {
    split({ r | r := commands[_]; startswith(r, flag) }[_], "=")[1] > argument
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
	commands := hasContainersCommand[_]
    hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	commands := hasContainersCommand[_]
    not hasCommand(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": getContainerCommand[_] }
}
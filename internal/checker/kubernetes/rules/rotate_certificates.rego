# METADATA
# title: "Verify that the --rotate-certificates argument not set to false"
# description: "The --rotate-certificates setting causes the kubelet to rotate its client certificates by creating new CSRs as its existing credentials expire"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/ 
# custom:
#   id: CB_K8S_052
#   severity: HIGH
package lib.kubernetes.CB_K8S_052

import data.lib.kubernetes

resource = kubernetes.resource

default flag := "--rotate-certificates"
default argument := "false"


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

hasReadOnlyPort(container) {
    kubernetes.has_container_command(container, flag, argument)
}

getContainerCommand[container] {
    startswith(kubernetes.containers[index].command[command_index], flag)
    container := kubernetes.containers[index]
}

passed[result] {
    isValid
	commands := hasContainersCommand[_]
    not hasReadOnlyPort(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to 'true'", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	commands := hasContainersCommand[_]
    hasReadOnlyPort(commands)
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must not be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand[_] }
}

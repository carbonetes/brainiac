# METADATA
# title: "Verify that the --bind-address is set to 127.0.0.1"
# description: "Ensure that the --bind-address is set to 127.0.0.1"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/
# custom:
#   id: CB_K8S_081
#   severity: HIGH
package lib.kubernetes.CB_K8S_081

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--bind-address"
default argument := "127.0.0.1"
default check := false

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand {
    commands := kubernetes.containers_commands
    commands[_] == "kube-controller-manager"
}

check {
	not hasContainersCommand
}

check {
    kubernetes.has_container_command(kubernetes.containers_commands, flag, argument)
}

getContainerCommand := result if {
    some index, command_index
	startswith(kubernetes.containers[index].command[command_index], flag)
    result := kubernetes.containers[index]
} else := result if {
    result := {}
}

passed[result] {
    isValid
	check
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet":  getContainerCommand }
}

failed[result] {
    isValid
	not check
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s'", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand }
}
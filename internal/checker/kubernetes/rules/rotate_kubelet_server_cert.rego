# METADATA
# title: "Verify that the RotateKubeletServerCertificate is set to true"
# description: "Ensure that the RotateKubeletServerCertificate is set to true"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/
# custom:
#   id: CB_K8S_071
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_071

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--feature-gates"
default argument := "true"
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
    commands[_] == "kubelet"
}

hasCommandFlag {
    commands := kubernetes.containers_commands
    startswith(commands[_], flag)
}

check {
	not hasContainersCommand
}

check {
    not hasCommandFlag
}

check {
    has_container_command(kubernetes.containers_commands, flag, argument)
}

has_container_command(key, flag, argument) {
	command := split({ r | r := key[_]; startswith(r, flag) }[_], "=")
    command[1] == "RotateKubeletServerCertificate"
    command[2] == argument
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
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set to '%s' file", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet":  getContainerCommand }
}

failed[result] {
    isValid
	not check
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is must be set to '%s' file", [kubernetes.kind, kubernetes.name, flag, argument]),
                "snippet": getContainerCommand }
}
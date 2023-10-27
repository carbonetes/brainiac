# METADATA
# title: "Verify that the --use-service-account-credentials argument is set to true"
# description: "Ensure that the --use-service-account-credentials argument is set to true"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# custom:
#   id: CB_K8S_058
#   severity: HIGH
package lib.kubernetes.CB_K8S_058

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--use-service-account-credentials"
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
    commands[_] == "kube-controller-manager"
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
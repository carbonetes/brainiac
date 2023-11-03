# METADATA
# title: "Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
# description: "Ensure that the --event-qps is set to 0 or a level that ensures appropriate event capture"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
# custom:
#   id: CB_K8S_049
#   severity: HIGH
package lib.kubernetes.CB_K8S_049

import data.lib.kubernetes

resource = kubernetes.resource

default flag_0 := "--tls-cert-file"
default flag_1 := "--tls-private-key-file"
default config_command := "kube-apiserver"
default hasContainersCommand := false

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand {
    commands := kubernetes.containers_commands
    commands[_] == config_command
    startswith(commands[_], flag_0)
    startswith(commands[_], flag_1)
}

getContainerCommand[container] {
    some index, command_index
    startswith(kubernetes.containers[index].command[command_index], flag_0)
    container := kubernetes.containers[index]
}

passed[result] {
    isValid
	hasContainersCommand
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' and '%s' is properly set", [kubernetes.kind, kubernetes.name, flag_0, flag_1]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
	not hasContainersCommand
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' and '%s' is not set", [kubernetes.kind, kubernetes.name, flag_0, flag_1]),
                "snippet": {} }
}
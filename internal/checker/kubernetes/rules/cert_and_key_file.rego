# METADATA
# title: "Verify that the --cert-file and --key-file arguments are set properly"
# description: "Ensure that the --cert-file and --key-file arguments are set properly"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/setup/best-practices/certificates/
# custom:
#   id: CB_K8S_082
#   severity: HIGH
package lib.kubernetes.CB_K8S_082

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag_0 := "--cert-file"
default flag_1 := "--key-file"
default config_command := "etcd"

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand := container if {
    container := kubernetes.containers[_]
    container.command[_] == config_command
    startswith(container.command[_], flag_0)
    startswith(container.command[_], flag_1)
} else := container if {
    container := {}
}

pass {
    count(hasContainersCommand) > 0
}

pass {
    container := kubernetes.containers[_]
    command := container.command[_] == config_command
    not command
    count(hasContainersCommand) < 1
}

fail {
    count(hasContainersCommand) < 1
}

passed[result] {
    isValid
	pass
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' and '%s' is properly set", [kubernetes.kind, kubernetes.name, flag_0, flag_1]),
                "snippet": hasContainersCommand }
}

failed[result] {
    isValid
    container := kubernetes.containers[_]
    container.command[_] == config_command
	fail
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' and '%s' is not set properly", [kubernetes.kind, kubernetes.name, flag_0, flag_1]),
                "snippet": hasContainersCommand }
}
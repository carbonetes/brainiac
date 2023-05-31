# METADATA
# title: "Verify that the --client-ca-file arguments is set properly"
# description: "Ensure that the --client-ca-file arguments is set properly"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/setup/best-practices/certificates/
# custom:
#   id: CB_K8S_092
#   severity: HIGH
package lib.kubernetes.CB_K8S_092

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--client-ca-file"
default config_command := "kubelet"

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
    startswith(container.command[_], flag)
} else := container if {
    container := {}
}

check {
    count(hasContainersCommand) > 0
}

passed[result] {
    isValid
	check
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": hasContainersCommand }
}

failed[result] {
    isValid
	not check
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is not set properly", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": hasContainersCommand }
}
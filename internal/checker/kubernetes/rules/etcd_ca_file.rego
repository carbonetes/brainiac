# METADATA
# title: "Verify that the --etcd-cafile arguments is set properly"
# description: "Ensure that the --etcd-cafile arguments is set properly"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/setup/best-practices/certificates/
# custom:
#   id: CB_K8S_093
#   severity: HIGH
package lib.kubernetes.CB_K8S_093

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--etcd-ca-file"
default config_command := "kube-apiserver"

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
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is properly set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": hasContainersCommand }
}

failed[result] {
    isValid
    container := kubernetes.containers[_]
    container.command[_] == config_command
	fail
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is not set properly", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": hasContainersCommand }
}
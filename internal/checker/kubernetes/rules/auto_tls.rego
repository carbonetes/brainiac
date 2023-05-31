# METADATA
# title: "Verify that the --auto-tls arguments is set properly"
# description: "Ensure that the --auto-tls arguments is set properly"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/setup/best-practices/certificates/
# custom:
#   id: CB_K8S_085
#   severity: HIGH
package lib.kubernetes.CB_K8S_085

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--auto-tls"
default argument := "true"
default config_command := "etcd"
default check := true

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersCommand := container if {
    container := kubernetes.containers[_]
    startswith(container.command[_], flag)
    split(container.command[_], "=")[1] == argument
} else := container if {
    container := kubernetes.containers[_]
    startswith(container.command[_], flag)
    split(container.command[_], "=")[1] != argument
} else := container if {
    container := {}
}

check := false if {
    container := hasContainersCommand
    startswith(container.command[_], flag)
    split(container.command[_], "=")[1] == argument
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
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is not properly set", [kubernetes.kind, kubernetes.name, flag]),
                "snippet": hasContainersCommand }
}
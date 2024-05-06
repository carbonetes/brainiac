# METADATA
# title: "Make sure the —request-timeout option is configured correctly"
# description: "Keep the logs for at least 30 days, or however long is necessary."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#options-22
# custom:
#   id: CB_K8S_098
#   severity: LOW
package lib.kubernetes.CB_K8S_098

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

default flag := "--request-timeout"

default pass := true

validResource := ["CronJob", "Pod"]

isValid if {
	kubernetes.is_controller
}

isValid if {
	kubernetes.kind == validResource[_]
}

hasContainersCommand := container if {
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, flag)
	val := split(commands, "=")[1]
	regex.match("^(\\d{1,2}[h])(\\d{1,2}[m])?(\\d{1,2}[s])?$|^(\\d{1,2}[m])?(\\d{1,2}[s])?$|^(\\d{1,2}[s])$", val)
} else := container if {
	container := {}
}

pass := false if {
	count(hasContainersCommand) < 1
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, flag)
}

passed[result] {
	isValid
	pass
	result := {
		"message": sprintf("The commands for %s - %s with the flag of '%s' is properly set.", [kubernetes.kind, kubernetes.name, flag]),
		"snippet": hasContainersCommand,
	}
}

failed[result] {
	isValid
	not pass
	result := {
		"message": sprintf("The commands for %s - %s with the flag of '%s' is not set appropriately.", [kubernetes.kind, kubernetes.name, flag]),
		"snippet": hasContainersCommand,
	}
}

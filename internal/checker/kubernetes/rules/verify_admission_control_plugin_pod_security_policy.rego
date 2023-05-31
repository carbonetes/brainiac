# METADATA
# title: "Verify that the admission control plugin PodSecurityPolicy is set"
# description: "The PodSecurityPolicy admission controller enforces security policies on the pods created in a Kubernetes cluster. It restricts the use of privileged containers, host namespaces, and volume types to prevent potential security vulnerabilities."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-policy/#admission-controller
# custom:
#   id: CB_K8S_073
#   severity: LOW
package lib.kubernetes.CB_K8S_073
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


passedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	contains(commands, "=")
	args := split(commands, "=")[1]
	contains(args, "PodSecurityPolicy")
}

failedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	not contains(commands, "=")
}

failedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not passedCheck[container]
}

passed[result] {
	isValid
	res := passedCheck[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' 'PodSecurityPolicy' is set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := failedCheck[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' 'PodSecurityPolicy' should be set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
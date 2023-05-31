# METADATA
# title: "Verify that the admission control plugin NodeRestriction is set"
# description: "The NodeRestriction admission controller enforces restrictions on the use of privileged containers, host namespaces, and volume types for pods that are scheduled to run on Kubernetes worker nodes. "
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noder
# custom:
#   id: CB_K8S_074
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_074
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	contains(commands, "=")
	args := split(commands, "=")[1]
	contains(args, "NodeRestriction")
}
noServiceAccount[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	not contains(commands, "=")
}
noServiceAccount[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' 'NodeRestriction' is set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := noServiceAccount[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' 'NodeRestriction' should be set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
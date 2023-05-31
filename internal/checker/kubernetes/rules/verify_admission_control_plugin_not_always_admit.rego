# METADATA
# title: "Verify that the admission control plugin AlwaysAdmit is not set"
# description: "To ensure the security and integrity of your Kubernetes clusters, it is important to verify that the AlwaysAdmit plugin is not set."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#admission-control
# custom:
#   id: CB_K8S_064
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_064
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
	contains(args, "AlwaysAdmit")
}
check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	not contains(commands, "=")
}
noAdmissionPlugin[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := noAdmissionPlugin[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' is not set", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' should not set or has value of AlwaysAdmit", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
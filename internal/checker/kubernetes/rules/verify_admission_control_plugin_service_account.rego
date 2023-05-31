# METADATA
# title: "Verify that the admission control plugin ServiceAccount is set"
# description: "It is important to note that the ServiceAccount admission control plugin is enabled by default in most Kubernetes deployments, but it is still a good practice to verify that it is enabled to ensure the security and stability of your cluster."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#serviceaccount
# custom:
#   id: CB_K8S_067
#   severity: LOW
package lib.kubernetes.CB_K8S_067
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
	contains(args, "ServiceAccount")
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
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' 'ServiceAccount' is set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := noServiceAccount[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' 'ServiceAccount' should be set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
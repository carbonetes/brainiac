# METADATA
# title: "Verify that the --authorization-mode argument contains RBAC."
# description: "This argument specifies the authorization mode used by the API server, which can be set to RBAC among other options."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#options-46
# custom:
#   id: CB_K8S_063
#   severity: LOW
package lib.kubernetes.CB_K8S_063
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
	startswith(commands, "--authorization-mode")
	args := split(commands, "=")[1]
	contains(args, "RBAC")
}
authModeNotContainRBAC[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--authorization-mode' has 'RBAC' value", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := authModeNotContainRBAC[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--authorization-mode' should include 'RBAC'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
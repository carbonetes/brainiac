# METADATA
# title: "Verify that the --authorization-mode argument is not set to AlwaysAllow."
# description: "Verifying that the --authorization-mode argument is not set to AlwaysAllow helps to ensure that the Kubernetes cluster is properly secured and that API requests are authorized only for authorized users and applications."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#options-46
# custom:
#   id: CB_K8S_061
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_061
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
	contains(args, "AlwaysAllow")
}
authModeNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := authModeNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--authorization-mode' is not set to 'AlwaysAllow", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--authorization-mode' should not be set to AlwaysAllow", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
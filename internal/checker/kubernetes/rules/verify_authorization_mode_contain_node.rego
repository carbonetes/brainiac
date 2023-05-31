# METADATA
# title: "Verify that the --authorization-mode argument contains Node."
# description: "Verifying that the --authorization-mode argument contains Node helps to ensure that the Kubernetes cluster is properly configured to allow nodes to access the API server and perform necessary operations."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#options-46
# custom:
#   id: CB_K8S_062
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_062
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
	contains(args, "Node")
}
authModeNotContainNode[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--authorization-mode' has 'Node' value", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := authModeNotContainNode[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--authorization-mode' should include 'Node'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
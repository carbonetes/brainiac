# METADATA
# title: "Verify that the --insecure-port argument is set to 0."
# description: "To ensure the security of your Kubernetes cluster, it is important to verify that the --insecure-port argument is set to 0."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#insecure-port
# custom:
#   id: CB_K8S_076
#   severity: HIGH
package lib.kubernetes.CB_K8S_076
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
	contains(commands, "--insecure-port=0")
}

portIsNotProperlySet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--insecure-port' is set properly.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := portIsNotProperlySet[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--insecure-port' should be set to 0.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
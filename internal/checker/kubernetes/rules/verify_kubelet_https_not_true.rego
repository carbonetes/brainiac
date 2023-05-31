# METADATA
# title: "Verify that --kubelet-https argument is set to True"
# description: "The --kubelet-https argument is a configuration option for the Kubernetes API server that specifies whether to use HTTPS to communicate with the kubelet, which is responsible for managing containers on each node in the cluster."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/authentication/
# custom:
#   id: CB_K8S_057
#   severity: LOW
package lib.kubernetes.CB_K8S_057
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
	startswith(commands, "--kubelet-https")
	contains(commands, "=false")
}
kubeleSetToTrueOrNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := kubeleSetToTrueOrNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--kubelet-https' is set properly", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--kubelet-https' should be set to true", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
# METADATA
# title: "Verify the --anonymous-auth argument is set to False"
# description: "If Enabled, requests that are not rejected by other configured authentication methods are treated as anonymous requests."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/kubelet-authn-authz/
# custom:
#   id: CB_K8S_054
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_054
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

is_kubelet(container){
	kubernetes.has_attribute(container, "command")
	contains(container.command[_], "kubelet")
}

check[container]{
	container := kubernetes.containers[_]
	is_kubelet(container)
	commands := container.command[_]
	startswith(commands, "--anonymous-auth")
	contains(commands, "=false")
}
anonymousAuthTrue[container]{
	container := kubernetes.containers[_]
	is_kubelet(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command' for '--anonymous-auth' is properly set to false", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := anonymousAuthTrue[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--anonymous-auth' should set to false", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
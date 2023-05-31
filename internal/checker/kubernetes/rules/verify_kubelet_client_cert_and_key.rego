# METADATA
# title: "Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately"
# description: "These arguments must be set appropriately to ensure secure communication between the API server and the kubelet."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/setup/best-practices/certificates/
# custom:
#   id: CB_K8S_059
#   severity: HIGH
package lib.kubernetes.CB_K8S_059
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasCertificate(container){
	kubernetes.has_attribute(container, "command")
	commands := container.command[_]
	startswith(commands, "--kubelet-client-certificate")
}

hasClientKey(container){
	kubernetes.has_attribute(container, "command")
	commands := container.command[_]
	startswith(commands, "--kubelet-client-key")
}

check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	hasCertificate(container)
	hasClientKey(container)
}

kubeletClientAndKeyNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--kubelet-client-certificate and --kubelet-client-key' is set properly", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := kubeletClientAndKeyNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--kubelet-client-certificate and --kubelet-client-key' should be set", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
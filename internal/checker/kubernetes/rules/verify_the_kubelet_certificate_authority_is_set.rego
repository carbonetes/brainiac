# METADATA
# title: "Verify that the --kubelet-certificate-authority argument is set as it should be."
# description: "If this argument is not set correctly, it can result in communication failures or security vulnerabilities in the cluster."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/#options-15
# custom:
#   id: CB_K8S_060
#   severity: HIGH
package lib.kubernetes.CB_K8S_060
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
	startswith(commands, "--kubelet-certificate-authority")
}
certificateAuthNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--kubelet-certificate-authority' is set properly", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := certificateAuthNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--kubelet-certificate-authority' should be set", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
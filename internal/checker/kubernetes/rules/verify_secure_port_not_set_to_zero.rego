# METADATA
# title: "Verify that the --secure-port argument is not set to 0"
# description: "Setting the --secure-port argument to 0 would disable secure connections and would make the API server listen on an insecure port, which could potentially allow unauthorized parties to intercept and read data."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#secure-port
# custom:
#   id: CB_K8S_077
#   severity: LOW
package lib.kubernetes.CB_K8S_077
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


securePortIsZero[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	contains(commands, "--secure-port=0")
}

check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not securePortIsZero[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--secure-port' is set properly.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := securePortIsZero[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--secure-port' should not be set to 0.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
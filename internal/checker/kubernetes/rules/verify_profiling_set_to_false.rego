# METADATA
# title: "Verify that the --profiling argument is set to false"
# description: "Verifying that the --profiling argument is set to false is important for ensuring that profiling is disabled for components that do not require it, as collecting unnecessary profiling data can impact system performance and consume resources."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/
# custom:
#   id: CB_K8S_078
#   severity: LOW
package lib.kubernetes.CB_K8S_078
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


profilingIsFalse[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	contains(commands, "--profiling=false")
}

check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not profilingIsFalse[container]
}

passed[result] {
	isValid
	res := profilingIsFalse[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--profiling' is set properly.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--profiling' should not be set to false.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
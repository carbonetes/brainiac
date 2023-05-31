# METADATA
# title: "Verify Tiller (Helm V2) deployment is not accessible from within the cluster"
# description: "The capabilities of a compromised pod or anonymous user within the cluster are restricted by limiting access to Tiller from within the cluster. The Tiller service can be terminated after limiting connectivity to the Tiller deployment."
# scope: package
# related_resources:
# - https://medium.com/@elijudah/configuring-minimal-rbac-permissions-for-helm-and-tiller-e7d792511d10
# custom:
#   id: CB_K8S_050
#   severity: LOW
package lib.kubernetes.CB_K8S_050
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hostValues := ["localhost", "127.0.0.1"]

is_tiller(container){
	contains(container.image, "tiller")
}

check[container]{
	container := kubernetes.containers[_]
	is_tiller(container)
	kubernetes.has_attribute(container, "args")
	args := container.args[_]
	startswith(args, "--listen")
	contains(args, hostValues[_])
	
}

tillerIsExpose[container]{
	container := kubernetes.containers[_]
	is_tiller(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Configuration for %s '%s' does not have accesible 'tiller'", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := tillerIsExpose[_]
	result := {"message" : sprintf("Configuration for %s '%s' 'tiller' should not be accesible", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
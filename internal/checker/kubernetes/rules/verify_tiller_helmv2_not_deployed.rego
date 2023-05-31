# METADATA
# title: "Verify Tiller (Helm V2) is not deployed"
# description: "The capabilities of a compromised pod or anonymous user within the cluster are restricted by limiting access to Tiller from within the cluster. The Tiller service can be terminated after limiting connectivity to the Tiller deployment."
# scope: package
# related_resources:
# - https://helm.sh/blog/helm-v2-deprecation-timeline/.
# custom:
#   id: CB_K8S_044
#   severity: LOW
package lib.kubernetes.CB_K8S_044
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
	contains(container.image, "tiller")
}


check[labels]{
	labels := kubernetes.metadata.labels
    kubernetes.has_attribute(labels, "app")
	labels.app == "helm"
}

check[labels]{
	labels := kubernetes.metadata.labels
    kubernetes.has_attribute(labels, "name")
	labels.name == "tiller"
}

noTiller[container]{
	container := kubernetes.containers[_]
	not check[container]

}
noTiller[labels]{
	labels := kubernetes.metadata.labels
	not check[labels]

}

passed[result] {
	isValid
	res := noTiller[_]
	result := {"message" : sprintf("Configuration for %s '%s' does not deployed 'tiller'", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Configuration for %s '%s' should not deploy 'tiller'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
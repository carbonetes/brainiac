# METADATA
# title: "Verify that the Kubernetes dashboard is not deployed."
# description: "The Kubernetes dashboard, if publicly deployed, will increase the likelihood of malicious attackers."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
# custom:
#   id: CB_K8S_035
#   severity: LOW
package lib.kubernetes.CB_K8S_035

import data.lib.kubernetes


resource = kubernetes.resource
dashBoardImage := ["kubernetes-dashboard", "kubernetesui"]

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


check[container]{
	container := kubernetes.containers[_]
	container.image == dashBoardImage[_]
}


check[labels]{
	labels := kubernetes.metadata.labels
    kubernetes.has_attribute(labels, "app")
	labels.app == dashBoardImage[0]
}


noDashboard[container]{
	container := kubernetes.containers[_]
	not check[container]

}
noDashboard[labels]{
	labels := kubernetes.metadata.labels
	not check[labels]

}

passed[result] {
	isValid
	res := noDashboard[_]
	result := {"message" : sprintf("Configuration for %s '%s' does not deployed 'kubernetes-dashboard'", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Configuration for %s '%s' should not deploy 'kubernetes-dashboard'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

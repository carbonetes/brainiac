# METADATA
# title: "Avoid using Image tag ':latest'"
# description: "Specified image tag when deploying containers in production. Doing so makes it easy to track which version of the image is running"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/overview/#container-images
# custom:
#   id: CB_K8S_008
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_008

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

getContainersHasTag[container] {
	container := kubernetes.containers[_]
	digest := split(container.image, "@")[1]
}

getContainersHasTag[container] {
	container := kubernetes.containers[_]
	tag := split(container.image, ":")[1]
	tag != "latest"
}

getUntaggedContainers[container] {
	container := kubernetes.containers[_]
	not getContainersHasTag[container]
}

passed[result] {
	isValid
	tagContainers := getContainersHasTag[_]
	result := {"message" : sprintf("Container '%s' of %s '%s' specified an image tag", [tagContainers.name, kubernetes.kind, kubernetes.name]),
			   "snippet": tagContainers
			  }
}
failed[result] {
	isValid
	untagContainers := getUntaggedContainers[_]
	result := {"message": sprintf("Container '%s' of %s '%s' should specify an image tag", [untagContainers.name, kubernetes.kind, kubernetes.name]),
	 			"snippet": untagContainers
			  }
}

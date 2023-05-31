# METADATA
# title: "Always specify Image Pull Policy as Always"
# description: "With imagePullPolicy set to Always, Kubernetes will always pull the image from the repository."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/overview/#container-images
# custom:
#   id: CB_K8S_010
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_010

import data.lib.kubernetes
import future.keywords.in


resource = kubernetes.resource
validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

hasContainersImagePullPolicy[container] {
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container, "imagePullPolicy")
}

passed[result] {
	isValid
	container := hasContainersImagePullPolicy[_]
    container.imagePullPolicy == "Always"
	result := {"message": sprintf("Container '%s' of %s '%s' is set to 'Always'", [container.name, kubernetes.kind, kubernetes.name]),
				"snippet": container
			  }
}
failed[result] {
	isValid
	container := hasContainersImagePullPolicy[_]
    container.imagePullPolicy != "Always"
	result := {"message" : sprintf("Container '%s' of %s '%s' should be set to 'Always'", [container.name, kubernetes.kind, kubernetes.name]),
				"snippet": container
			  }
}

# METADATA
# title: "SecurityContext is not applied to pods and containers"
# description: "A security context defines privilege and access control settings for a Pod or Container."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_033
#   severity: LOW
package lib.kubernetes.CB_K8S_033

import data.lib.kubernetes


resource = kubernetes.resource

checkSecurityContext[container]{
	container := kubernetes.containers[_]
  	kubernetes.has_attribute(container, "securityContext")

}

checkNoSecurityContext[container]{
	container := kubernetes.containers[_]
	not checkSecurityContext[container]
}


passed[result] {
	res := checkSecurityContext[_]
	result := {"message" : sprintf("Container of %s '%s' has a 'securityContext", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

failed[result] {
    res := checkNoSecurityContext[_]
	result := {"message" : sprintf("Container of %s '%s' should implement 'securityContext'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

# METADATA
# title: "The default namespace should not be used"
# description: "Ensure that all new resources are created in a specific namespace."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
# custom:
#   id: CB_K8S_001
#   severity: LOW
package lib.kubernetes.CB_K8S_001

import data.lib.kubernetes

default defaultNamespaceInUse = false

validResource := ["ConfigMap", 
				  "Ingress", 
				  "CronJob", 
				  "Pod", 
				  "Service", 
				  "ServiceAccount", 
				  "Role", 
				  "RoleBinding",
				  "Secret"]

isValid{
	kubernetes.is_controller
}
isValid{
	kubernetes.kind == validResource[_]
}
resource = kubernetes.resource

defaultNamespaceInUse {
	kubernetes.namespace == "default"
}

passed[result] {
	isValid
	not defaultNamespaceInUse
	result := {"message":  sprintf("%s '%s' is not set with 'default' namespace", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.metadata
	}
}
failed[result] {
	isValid
	defaultNamespaceInUse
	result := {"message": sprintf("%s '%s' should not be set with 'default' namespace", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.metadata
	}
}

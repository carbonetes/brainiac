# METADATA
# title: "Avoid allowing containers to distribute the host network namespace"
# description: "It is possible to make the host exposed to other containers in the pod by spreading the host network namespace, which destroys the exclusion between container images."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/security/#network-security
# custom:
#   id: CB_K8S_103
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_103

import data.lib.kubernetes

resource = kubernetes.resource


reject {
    kubernetes.is_psp
    kubernetes.spec.hostNetwork == true
}

passed[result] {
	kubernetes.is_psp
	not reject
	result := {"message":  sprintf("%s '%s' 'hostNetwork' is not enabled ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	reject
	result := {"message": sprintf("%s '%s' 'hostNetwork' is  enabled ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

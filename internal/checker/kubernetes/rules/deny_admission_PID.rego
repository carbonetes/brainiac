# METADATA
# title: "Do not allow containers that want to distribute the host process ID namespace to be accepted"
# description: "Sharing the host process ID namespace allows processes to become visible to other containers in the pod, breaking the exclusion between container images."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-standards/#host-namespaces
# custom:
#   id: CB_K8S_100
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_100

import data.lib.kubernetes

resource = kubernetes.resource


reject {
    kubernetes.is_psp
    kubernetes.spec.hostPID == true
}

passed[result] {
	kubernetes.is_psp
	not reject
	result := {"message":  sprintf("%s '%s' 'hostPID' is not enabled ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	reject
	result := {"message": sprintf("%s '%s' 'hostPID' is  enabled ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

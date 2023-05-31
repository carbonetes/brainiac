# METADATA
# title: "Avoid allowing containers that want to distribute the host's IPC namespace"
# description: "To maintain effective exclusion between Docker containers and the underlying host, having to share host PID/IPC namespace, networking, and ports must be restricted."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-standards/
# custom:
#   id: CB_K8S_102
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_102

import data.lib.kubernetes

resource = kubernetes.resource


reject {
    kubernetes.is_psp
    kubernetes.spec.hostIPC == true
}

passed[result] {
	kubernetes.is_psp
	not reject
	result := {"message":  sprintf("%s '%s' 'hostIPC' is not enabled ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	reject
	result := {"message": sprintf("%s '%s' 'hostIPC' is  enabled ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

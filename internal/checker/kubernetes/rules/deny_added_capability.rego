# METADATA
# title: "Make sure that no containers with extra functionality are permitted"
# description: "Additional capabilities grant containers in a pod more rights that can be used to modify a cluster's fundamental operating procedures and networking configurations."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-admission/
# custom:
#   id: CB_K8S_106
#   severity: LOW
package lib.kubernetes.CB_K8S_106

import data.lib.kubernetes

resource = kubernetes.resource


deny {
    kubernetes.is_psp
	added := kubernetes.spec
    kubernetes.has_attribute(added, "allowedCapabilities")
}

passed[result] {
	kubernetes.is_psp
	not deny
	result := {"message":  sprintf("%s '%s' 'added' capability is restricted ", [kubernetes.kind, kubernetes.name]),
			"snippet" : {}
	}
}
failed[result] {
	deny
	result := {"message": sprintf("%s '%s' 'added' capability is not restricted ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

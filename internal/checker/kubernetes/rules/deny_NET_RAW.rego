# METADATA
# title: "Refuse to accept containers with the NET RAW capability"
# description: "When used by an attacker, NET RAW can open the cluster up to a wide range of networking attacks."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/pod-security-admission/
# custom:
#   id: CB_K8S_105
#   severity: LOW
package lib.kubernetes.CB_K8S_105

import data.lib.kubernetes

resource = kubernetes.resource


check {
    kubernetes.is_psp
    requiredDropCapabilities := kubernetes.spec.requiredDropCapabilities
    regex.match(`\bALL\b`, requiredDropCapabilities)
}

check {
    kubernetes.is_psp
    requiredDropCapabilities := kubernetes.spec.requiredDropCapabilities
    regex.match(`\bNET_RAW\b`, requiredDropCapabilities)
}

passed[result] {
	kubernetes.is_psp
	check
	result := {"message":  sprintf("%s '%s' 'NET_RAW' capability is dropped ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	kubernetes.is_psp
	not check
	result := {"message": sprintf("%s '%s' 'NET_RAW' capability is not dropped ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

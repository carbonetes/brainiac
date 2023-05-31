# METADATA
# title: "Privileged containers must not be allowed"
# description: "Users are given integral access to the host's resources when a container is running with the privileged flag."
# scope: package
# related_resources:
# - https://kubernetes.io/blog/2016/08/security-best-practices-kubernetes-deployment/
# custom:
#   id: CB_K8S_101
#   severity: HIGH
package lib.kubernetes.CB_K8S_101

import data.lib.kubernetes

resource = kubernetes.resource


reject {
    kubernetes.is_psp
    kubernetes.spec.privileged == true
}

passed[result] {
	kubernetes.is_psp
	not reject
	result := {"message":  sprintf("%s '%s' 'privileged' is not enabled ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
	reject
	result := {"message": sprintf("%s '%s' 'privileged' is  enabled ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

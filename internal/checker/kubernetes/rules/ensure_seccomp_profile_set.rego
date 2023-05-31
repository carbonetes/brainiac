# METADATA
# title: "Make sure that runtime/Default or docker/default is selected in seccomp profile"
# description: "Seccomp's default profile, which prevents unnecessary system calls, offers a dependable setting for running containers with seccomp."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tutorials/clusters/seccomp/
# custom:
#   id: CB_K8S_107
#   severity: LOW
package lib.kubernetes.CB_K8S_107

import data.lib.kubernetes

resource = kubernetes.resource

seccomp_annotation := "seccomp.security.alpha.kubernetes.io/defaultProfileName"
default_seccomp_profile_docker := "docker/default"
default_seccomp_profile_runtime := "runtime/default"


check {
    kubernetes.metadata.annotations[seccomp_annotation] == default_seccomp_profile_docker
}

check {
    kubernetes.metadata.annotations[seccomp_annotation] == default_seccomp_profile_runtime
}

passed[result] {
	kubernetes.is_psp
	check
	result := {"message":  sprintf("%s '%s' runtime/Default or docker/default is set in seccomp profile ", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.metadata
	}
}
failed[result] {
	kubernetes.is_psp
	not check
	result := {"message": sprintf("%s '%s' runtime/Default or docker/default is not set in seccomp profile ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.metadata
	}
}

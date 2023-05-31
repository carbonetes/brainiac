# METADATA
# title: "Do not expose Docker's socket to containers"
# description: "To protect the docker socket, limit the mounting of Docker socket daemon in a container"
# scope: package
# related_resources:
# - https://docs.docker.com/engine/security/protect-access/
# custom:
#   id: CB_K8S_031
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_031

import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

check {
	isValid
	volumes := kubernetes.volumes
	volumes[_].hostPath.path == "/var/run/docker.sock"
}

passed[result] {
	isValid
	not check
	result := {"message":  sprintf("%s '%s' volume is not mounted with '/var/run/docker.sock'", [kubernetes.kind, kubernetes.name]),
			  "snippet" : kubernetes.podTemplates[_].spec
	}
}
failed[result] {
	check
	result := {"message": sprintf("%s '%s' should not mount '/var/run/docker.sock'", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.podTemplates[_].spec
	}
}

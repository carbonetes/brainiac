# METADATA
# title: "Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used"
# description: "If PodSecurityPolicy is not used, it is important to ensure that the SecurityContextDeny admission control plugin is set to prevent insecure Pods from being created."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#securitycontextdeny
# custom:
#   id: CB_K8S_066
#   severity: LOW
package lib.kubernetes.CB_K8S_066
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

failedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	contains(commands, "=")
	args := split(commands, "=")[1]
	not contains(args, "PodSecurityPolicy")
	not contains(args, "SecurityContextDeny")
}

failedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	not contains(commands, "=")
}

passedCheck[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not failedCheck[container]
}

passed[result] {
	isValid
	res := passedCheck[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' 'SecurityContextDeny/PodSecurityPolicy' is set", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := failedCheck[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' should set or has value of 'SecurityContextDeny/PodSecurityPolicy'", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
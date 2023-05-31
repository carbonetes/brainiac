# METADATA
# title: "Verify that seccomp is configured as Docker/Default or Runtime/Default."
# description: "Seccomp stands for secure computing mode and has been a feature of the Linux kernel since version 2.6.12. It can be used to sandbox the privileges of a process, restricting the calls it is able to make from userspace into the kernel."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tutorials/security/seccomp/
# custom:
#   id: CB_K8S_034
#   severity: LOW
package lib.kubernetes.CB_K8S_034

import data.lib.kubernetes


resource = kubernetes.resource
seccompProfileType := ["RuntimeDefault", "DockerDefault"]

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

checkSeccompProfile[pods]{
	isValid
	pods := kubernetes.podTemplates[_]
    kubernetes.has_attribute(pods.spec, "securityContext")
	seccompProfile := pods.spec.securityContext.seccompProfile
	seccompProfile.type == seccompProfileType[_]
}
checkNoSeccompProfile[pods]{
	isValid
	pods := kubernetes.podTemplates[_]
	not checkSeccompProfile[pods]
}
passed[result] {
	res := checkSeccompProfile[_]
	result := {"message" : sprintf("Configuration for %s '%s' 'securityContext.seccompProfile' is set to 'RuntimeDefault/DockerDefault'", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res.spec.securityContext.seccompProfile}
}

failed[result] {
    res := checkNoSeccompProfile[_]
	result := {"message" : sprintf("Configuration for %s '%s' 'securityContext.seccompProfile' should set 'RuntimeDefault/DockerDefault'", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

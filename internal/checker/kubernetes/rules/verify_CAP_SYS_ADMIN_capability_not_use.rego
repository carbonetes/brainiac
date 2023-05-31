# METADATA
# title: "Verify CAP_SYS_ADMIN capability is not use."
# description: "To reduce the attack surface of your containers, restrict CAP_SYS_ADMIN Linux capabilities."
# scope: package
# related_resources:
# - https://github.com/syslog-ng/syslog-ng/issues/437
# custom:
#   id: CB_K8S_045
#   severity: LOW
package lib.kubernetes.CB_K8S_045

import data.lib.kubernetes
import future.keywords.in


resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

check[capabilities]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext, "capabilities")
    capabilities := container.securityContext.capabilities
	capabilities.add[_] == "SYS_ADMIN"

}

noSysAdmin[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container.securityContext, "capabilities")
}

noSysAdmin[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container, "securityContext")
}
noSysAdmin[capabilities]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container.securityContext, "capabilities")
    capabilities := container.securityContext.capabilities
	not check[capabilities]
}


passed[result] {
	isValid
	res := noSysAdmin[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.capabilities' does not contain 'SYS_ADMIN' capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) of %s '%s' 'securityContext.capabilities' should not add 'SYS_ADMIN' capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

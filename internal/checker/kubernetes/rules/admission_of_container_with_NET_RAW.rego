# METADATA
# title: "Admission of containers with NET_RAW capability is not minimized"
# description: "NET_RAW capability allows the binary to use RAW and PACKET sockets as well as binding to any address for transparent proxying."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
# custom:
#   id: CB_K8S_032
#   severity: LOW
package lib.kubernetes.CB_K8S_032

import data.lib.kubernetes
import future.keywords.in


resource = kubernetes.resource
dropCapabilities := ["ALL", "NET_RAW"]

checkContainersCapabilitiesWithDrop[container]{
	container := kubernetes.containers[_]
    capabilities := container.securityContext.capabilities.drop
	some i, _ in capabilities
    	capabilities[i] == dropCapabilities[_]

}

noContainersCapabilitiesWithDrop[container]{
	container := kubernetes.containers[_]
	not checkContainersCapabilitiesWithDrop[container]
}


passed[result] {
	res := checkContainersCapabilitiesWithDrop[_]
	result := {"message" : sprintf("Container of %s '%s' 'securityContext.capabilities' has 'ALL' and 'NET_RAW capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

failed[result] {
    res := noContainersCapabilitiesWithDrop[_]
	result := {"message" : sprintf("Container of %s '%s' 'securityContext.capabilities' should drop 'ALL' and 'NET_RAW capabilities", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

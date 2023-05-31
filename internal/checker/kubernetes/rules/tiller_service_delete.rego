# METADATA
# title: "Delete the Tiller (Helm v2) service."
# description: "The capabilities of a compromised pod or anonymous user within the cluster are restricted by limiting access to Tiller from within the cluster. The Tiller service can be terminated after limiting connectivity to the Tiller deployment."
# scope: package
# related_resources:
# - https://v2.helm.sh/docs/install/#:~:text=Deleting%20or%20Reinstalling%20Tiller,or%20more%20concisely%20helm%20reset%20.
# custom:
#   id: CB_K8S_029
#   severity: LOW
package lib.kubernetes.CB_K8S_029

import data.lib.kubernetes
import future.keywords.in 

resource = kubernetes.resource

default check = false

check {
	kubernetes.is_service
	resourceLabels := ["tiller"]
	labels := kubernetes.labels
	some i, _ in labels
		labels[i] == resourceLabels[_]
}

check {
	kubernetes.is_service
	kubernetes.name == "tiller-deploy"
}

check {
	kubernetes.is_service
	resourceSelector := ["tiller"]
	selector := kubernetes.selector
	some i, _ in selector
		selector[i] == resourceSelector[_]
}

passed[result] {
	kubernetes.is_service
	not check
	result := {"message" : sprintf("%s '%s' is granted", [kubernetes.kind, kubernetes.name]),
            "snippet" : kubernetes.metadata
    }
}
failed[result] {
	check
	result := {"message" : sprintf("%s '%s'  is invalid, avoid using Tiller (Helm v2) service.", [kubernetes.kind, kubernetes.name]),
            "snippet" : kubernetes.metadata
    }
}
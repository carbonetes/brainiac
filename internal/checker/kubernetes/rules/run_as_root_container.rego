# METADATA
# title: "No root containers are allowed"
# description: "Run-as-root containers frequently have more permissions than they need, which, in the event of a breach, could aid an attacker in developing their attacks."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/
# custom:
#   id: CB_K8S_068
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_068

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource


check {
    kubernetes.is_psp
    kubernetes.has_attribute(kubernetes.spec, "runAsUser")
    inspected_value := kubernetes.spec.rule
    inspected_value == "MustRunAsNonRoot"
}

check {
    kubernetes.is_psp
    kubernetes.has_attribute(kubernetes.spec, "runAsUser")
    inspected_value := kubernetes.spec.rule
    inspected_value == "MustRunAs"
    some i
    kubernetes.spec.ranges[i].min >= 0
}





passed[result] {
	kubernetes.is_psp
	check
	result := {"message":  sprintf("%s '%s' is not running as root container", [kubernetes.kind, kubernetes.name]),
			"snippet" : kubernetes.spec
	}
}
failed[result] {
    kubernetes.is_psp
	not check
	result := {"message": sprintf("%s '%s' 'is running as root container ", [kubernetes.kind, kubernetes.name]),
				"snippet" : kubernetes.spec
	}
}

# METADATA
# title: "Verify account tokens not mounted where necessary."
# description: "Many workloads do not need to contact the API server and should therefore have automountServiceAccountToken set to false."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# custom:
#   id: CB_K8S_042
#   severity: LOW
package lib.kubernetes.CB_K8S_042

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
    pods := kubernetes.podTemplates[_]
	pods.spec.automountServiceAccountToken == false
}

passed[result] {
    isValid
    check
    pods := kubernetes.podTemplates[_]
    result := {"message" : sprintf("%s '%s' 'automountServiceAccountToken' is disabled", [kubernetes.kind, kubernetes.name]),
            "snippet" : pods.spec
    }
}

failed[result] {
    isValid
    not check
    pods := kubernetes.podTemplates[_]
    result := {"message" : sprintf("%s '%s' should not be enabled with 'automountServiceAccountToken'", [kubernetes.kind, kubernetes.name]),
            "snippet" : pods.spec
    }
}
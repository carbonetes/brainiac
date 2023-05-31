# METADATA
# title: "Make sure default service accounts are not being utilized"
# description: "To enable easier auditing and inspection of the rights granted to applications, the default service account should not be used."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# custom:
#   id: CB_K8S_005
#   severity: LOW
package lib.kubernetes.CB_K8S_005

import data.lib.kubernetes

resource = kubernetes.resource

supportedKinds := ["RoleBinding", "ClusterRoleBinding"]
is_supported{
    kubernetes.kind == supportedKinds[_]
}
serviceAccountInUse[metadata] {
    kubernetes.is_serviceaccount
    metadata := kubernetes.metadata
	metadata.name == "default"
	not metadata.automountServiceAccountToken == false
}

serviceAccountInUse[subjects] {
    is_supported
	subjects :=  kubernetes.subjects[_]
	subjects.kind == "ServiceAccount"
    subjects.name == "default"
}

serviceAccountNotInUse[metadata] {
    kubernetes.is_serviceaccount
    metadata := kubernetes.metadata
   not serviceAccountInUse[metadata]
}


serviceAccountNotInUse[subjects] {
    is_supported
	subjects :=  kubernetes.subjects[_]
    subjects.kind == "ServiceAccount"
    not serviceAccountInUse[subjects]
}

passed[result] {
    res := serviceAccountNotInUse[_]
    result := {"message" : sprintf("%s '%s' is not using the 'default' service account", [kubernetes.kind, kubernetes.name]),
            "snippet" : res
    }
}

failed[result] {
    res := serviceAccountInUse[_]
    result := {"message" : sprintf("%s '%s' should not be set with 'default' service account", [kubernetes.kind, kubernetes.name]),
            "snippet" : res
    }
}
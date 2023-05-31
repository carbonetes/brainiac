# METADATA
# title: "ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups "
# description: "Ensure that ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups "
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# custom:
#   id: CB_K8S_024
#   severity: CRITICAL  
package lib.kubernetes.CB_K8S_024

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource


is_valid {
    kubernetes.kind in ["ClusterRole", "Role"]
}

is_failed {
    kubernetes.kind == "ClusterRole"
    count(kubernetes.filtered_rules([""], ["users","serviceaccounts"], ["*"])) > 0
}

is_failed {
    kubernetes.kind == "Role"
    count(kubernetes.filtered_rules(["*"], ["*","groups","users","serviceccounts"], ["impersonate"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'ServiceAccount' or 'ServiceAccount/Node' for user-accounts/users/groups", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := { "message": sprintf("%s '%s' - the use of 'impersonate' verbs from 'ServiceAccount' or 'Node' this could grant them access to the nodes", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules(["*",""], ["*","groups","users","serviceccounts"], ["*","impersonate"])[_] }
}
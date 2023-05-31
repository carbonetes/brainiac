# METADATA
# title: "ServiceAccount/Node should not able to all read secrets"
# description: "Ensure that ServiceAccount/Node should not able to all read secrets"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/secret/#service-account-token-secrets
# custom:
#   id: CB_K8S_026
#   severity: HIGH  
package lib.kubernetes.CB_K8S_026

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource


is_valid {
    kubernetes.is_rbac
}

is_failed {
    count(kubernetes.filtered_rules([""], ["secrets"], ["get", "watch", "list"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'ServiceAccount' or 'Node'", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := { "message": sprintf("%s '%s' - the use of 'get', 'watch', or 'list' verbs from 'ServiceAccount' or 'Node' this could grant them access to all secrets", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules([""], ["secrets"], ["get", "watch", "list"])[_] }
}
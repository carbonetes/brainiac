# METADATA
# title: "Should avoid the use of wildcard in Roles and ClusterRoles"
# description: "Ensure that wildcard is not used in Roles and ClusterRoles to prevent unecessary permission for a specific role."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole
# custom:
#   id: CB_K8S_009
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_009

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

default wildcard := "*"

is_valid {
	kubernetes.kind in ["Role", "ClusterRole"]
}

is_failed[rule] {
    some rule_index, index
    kubernetes.rules[rule_index].apiGroups[index] == wildcard
    rule := kubernetes.rules[rule_index]
}

is_failed[rule] {
    some rule_index, index
    kubernetes.rules[rule_index].resources[index] == wildcard
    rule := kubernetes.rules[rule_index]
}

is_failed[rule] {
    some rule_index, index
    kubernetes.rules[rule_index].verbs[index] == wildcard
    rule := kubernetes.rules[rule_index]
}

passed[result] {
    is_valid
	rule := is_failed
    result := sprintf("%s '%s' wildcard is not used in Roles and ClusterRoles.", [kubernetes.kind, kubernetes.name])
}

failed[result] {
	is_valid
	rule := is_failed
    result := { "message": sprintf("%s '%s' The use of wildcard in Roles and ClusterRoles should be avoided", [kubernetes.kind, kubernetes.name]),
                "snippet": rule[_] }
}


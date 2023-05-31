# METADATA
# title: "Limit the grant permission of Roles or ClusterRoles"
# description: "Ensure to minimize the grant permission of Roles or ClusterRoles"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole
# custom:
#   id: CB_K8S_020
#   severity: MEDIUM  
package lib.kubernetes.CB_K8S_020

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

is_valid {
    kubernetes.kind in ["ClusterRole", "Role"]
}

is_failed {
    count(kubernetes.filtered_rules(["rbac.authorization.k8s.io"], ["roles", "clusterroles"], ["escalate"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'roles' or 'clusterroles' from ClusterRole or Role", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := sprintf("%s '%s' - the use of 'escalate' verbs from 'roles' or 'clusterroles' could escalate privileges and possibly take over the entire cluster", [kubernetes.kind, kubernetes.name])
}
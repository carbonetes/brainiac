# METADATA
# title: "Limit the grant permission of RoleBindings or ClusterRoleBindings from ClusterRole or Role"
# description: "Ensure to minimize the grant permission of RoleBindings or ClusterRoleBindings from ClusterRole or Role"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/  
# custom:
#   id: CB_K8S_018
#   severity: MEDIUM  
package lib.kubernetes.CB_K8S_018

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

default api_groups := ["rbac.authorization.k8s.io"]
default resources := ["rolebindings", "clusterrolebindings"]
default verbs := ["bind"]

is_valid {
    kubernetes.kind in ["ClusterRole", "Role"]
}

is_failed {
    count(kubernetes.filtered_rules(api_groups, resources, verbs)) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'rolebindings' or 'clusterrolebindings' from ClusterRole or Role", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := {"message" : sprintf("%s '%s' - the use of 'bind' verbs from 'rolebindings' or 'clusterrolebindings' could escalate privileges and possibly take over the entire cluster", [kubernetes.kind, kubernetes.name]),
               "snippet" : kubernetes.filtered_rules(api_groups, resources, verbs)[_] }
}
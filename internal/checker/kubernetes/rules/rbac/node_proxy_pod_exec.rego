# METADATA
# title: "Limit the grant permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' "
# description: "Ensure to not the grant 'create' permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' "
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/security/rbac-good-practices/#privilege-escalation-risks
# custom:
#   id: CB_K8S_022
#   severity: HIGH  
package lib.kubernetes.CB_K8S_022

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

is_valid {
    kubernetes.kind in ["ClusterRole", "Role"]
}

is_failed {
    count(kubernetes.filtered_rules(["*"], ["pods/exec","pods"], ["*"])) > 0
}

is_failed {
    kubernetes.kind == "ClusterRole"
    count(kubernetes.filtered_rules([""], ["nodes/proxy"], ["create"])) > 0
}

is_failed {
    kubernetes.kind == "Role"
    count(kubernetes.filtered_rules([""], ["nodes/proxy","pods"], ["create", "list"])) > 0
}

is_failed {
    kubernetes.kind == "ClusterRole"
    count(kubernetes.filtered_rules(["rbac.authorization.k8s.io"], ["*"], ["bind", "create"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'nodes/proxy' or 'pods/exec' from ClusterRole", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := { "message": sprintf("%s '%s' - the use of 'create' verbs from 'nodes/proxy' or 'pods/exec' could potentially allow privilege escalation", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules(["rbac.authorization.k8s.io", ""], ["*", "nodes/proxy", "pods"], ["*", "list", "bind", "create"])[_] }
}
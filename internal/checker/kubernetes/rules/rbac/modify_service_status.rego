# METADATA
# title: "ServiceAccount/Node should not able to modify the `status.loadBalancer.ingress.ip` field"
# description: "Ensure that ServiceAccount/Node should not able modify the `status.loadBalancer.ingress.ip` field"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
# custom:
#   id: CB_K8S_027
#   severity: MEDIUM  
package lib.kubernetes.CB_K8S_027

import data.lib.kubernetes

resource = kubernetes.resource

is_valid {
     kubernetes.is_rbac
}

is_failed {
    count(kubernetes.filtered_rules(["rbac.authorization.k8s.io"], ["services/status"], ["*"])) > 0
}

is_failed {
    count(kubernetes.filtered_rules(["rbac.authorization.k8s.io"], ["*"], ["bind", "update"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'ServiceAccount' or 'Node'", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := { "message": sprintf("%s '%s' - the use of 'update' or 'bind' verbs from 'ServiceAccount' or 'Node' this could modify the services/status and set the `status.loadBalancer.ingress.ip` field to exploit the unfixed CVE-2020-8554 and launch MiTM attacks against the cluster", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules(["rbac.authorization.k8s.io"], ["*", "services/status"], ["*", "bind", "update"])[_] }
}
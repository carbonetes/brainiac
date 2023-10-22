# METADATA
# title: "Limit the permission of validating or mutating admission webhook configurations from ClusterRoles"
# description: "Ensure to minimize the permission of validating or mutating admission webhook configurations from ClusterRoles."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/
# custom:
#   id: CB_K8S_011
#   severity: HIGH
package lib.kubernetes.CB_K8S_011

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

default api_groups := ["admissionregistration.k8s.io"]
default resources := ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
default verbs := ["create", "update", "patch"]

is_valid {
	kubernetes.kind == "ClusterRole"
}

is_failed {
    count(kubernetes.filtered_rules(api_groups, resources, verbs)) > 0
}

getFilteredRules[kubernetes.filtered_rules(api_groups, resources, [""])]

passed[result] {
    is_valid
	not is_failed
    result := sprintf("%s '%s' - minimized permission of validating or mutating admission webhook configurations from ClusterRoles.", [kubernetes.kind, kubernetes.name])
}

failed[result] {
	is_valid
	is_failed
    result := { "message": sprintf("%s '%s' - the use of 'create', 'update', or 'patch' verbs from 'mutatingwebhookconfigurations' or 'validatingwebhookconfigurations' are granting control over admission webhooks", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules(api_groups, resources, verbs)[_] }
}


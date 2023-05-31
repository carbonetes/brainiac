# METADATA
# title: "Limit the permission of certificatesigningrequests/approval or signers from ClusterRoles"
# description: "Ensure to minimize the certificatesigningrequests/approval or signers from ClusterRoles."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/  
# custom:
#   id: CB_K8S_014
#   severity: HIGH
package lib.kubernetes.CB_K8S_014

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

is_valid {
    kubernetes.kind == "ClusterRole"
}

is_failed {
    count(kubernetes.filtered_rules(["certificates.k8s.io"], ["certificatesigningrequests/approval"], ["update", "patch"])) > 0
    count(kubernetes.filtered_rules(["certificates.k8s.io"], ["signers"], ["approve"])) > 0
}

passed[result] {
    is_valid
    not is_failed
    result := sprintf("%s '%s' - minimized permission of 'certificatesigningrequests/approval' or 'signers' from ClusterRoles.", [kubernetes.kind, kubernetes.name])
}

failed[result] {
    is_valid
    is_failed
    result := { "message": sprintf("%s '%s' - the use of 'update', 'patch', or 'approve' verbs from 'certificatesigningrequests/approval' or 'signers' are granting permissions to approve CertificateSigningRequests", [kubernetes.kind, kubernetes.name]),
                "snippet": kubernetes.filtered_rules(["certificates.k8s.io"], ["signers","certificatesigningrequests/approval"], ["approve","update", "patch"])[_] }
}
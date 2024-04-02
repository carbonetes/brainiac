# METADATA
# title: "RoleBinding should not allow privilege escalation to a ServiceAccount or Node on other RoleBinding"
# description: "It is crucial to make sure RoleBindings are set up in a way that prevents privilege escalation. Thus, a user with a RoleBinding should not be able to access any capabilities that are not explicitly granted to them by their RoleBinding."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-and-clusterrolebinding
# custom:
#   id: CB_K8S_025
#   severity: HIGH
package lib.kubernetes.CB_K8S_025

import data.lib.kubernetes
import future.keywords.in 

resource = kubernetes.resource

resourceKinds := ["ServiceAccount", "Node"]

check[subjects] {
	kubernetes.is_rbac	
    subjects :=  kubernetes.subjects[_]
	subjects.kind == resourceKinds[_]
}

noActiveServiceAccounts{
	kubernetes.is_rbac
	subjects := kubernetes.subjects[_]
	not check[subjects]
}

passed[result] {
    noActiveServiceAccounts
    result := {"message" : sprintf("%s '%s' is granted", [kubernetes.kind, kubernetes.name]),"snippet" : {}}
}
failed[result] {
    res := check[_]
    result := {"message" : sprintf("%s '%s'  is invalid due to the risk of privilege escalation being granted", [kubernetes.kind, kubernetes.name]),"snippet" : res}
}
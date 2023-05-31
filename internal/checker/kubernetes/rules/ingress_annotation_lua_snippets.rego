# METADATA
# title: "Prevent NGINX Ingress annotation snippets which contain LUA code execution. See CVE-2021-25742"
# description: "Enabling custom snippet annotations in ingress-nginx enables a user, who can build or alter ingress objects, to get all secrets in the cluster. It is advised to remove all instances of LUA code usage in order to continue allowing users to leverage the snippet feature."
# scope: package
# related_resources:
# - https://github.com/kubernetes/ingress-nginx/issues/7837
# custom:
#   id: CB_K8S_037
#   severity: LOW
package lib.kubernetes.CB_K8S_037

import data.lib.kubernetes
import future.keywords.in 

default check = false

resource = kubernetes.resource


check {
	kubernetes.is_ingress 
	annotations := kubernetes.metadata.annotations
	some key, _ in annotations
    contains(key, "snippet")
}

passed[result] {
	kubernetes.is_ingress 
	not check
	result := {"message" : sprintf("%s '%s' is granted.", [kubernetes.kind, kubernetes.name]),
            "snippet" : kubernetes.metadata
    }
}
failed[result] {
	check 
    result := {"message" : sprintf("%s '%s' is invalid, avoid using LUA code.", [kubernetes.kind, kubernetes.name]),
            "snippet" : kubernetes.metadata
    }
}
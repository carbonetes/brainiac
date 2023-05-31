# METADATA
# title: "Prevent All NGINX Ingress annotation snippets. See CVE-2021-25742"
# description: "A user who has the ability to build or modify ingress objects can access all secrets in the cluster by allowing custom snippet annotations in ingress-nginx. The best course of action is to forbid the use of any annotation snippets."
# scope: package
# related_resources:
# - https://github.com/kubernetes/ingress-nginx/issues/7837
# custom:
#   id: CB_K8S_047
#   severity: LOW
package lib.kubernetes.CB_K8S_047

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
    result := {"message" : sprintf("%s '%s' is invalid, avoid using NGINX Ingress annotation snippets.", [kubernetes.kind, kubernetes.name]),
            "snippet" : kubernetes.metadata
    }
}
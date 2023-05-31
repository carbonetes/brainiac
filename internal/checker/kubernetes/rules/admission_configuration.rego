# METADATA
# title: "Ensure that the admission control plugin EventRateLimit is set"
# description: "Set a limit on how many requests the API server can allow at once."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/
# custom:
#   id: CB_K8S_004
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_004

import data.lib.kubernetes
import future.keywords.in

resource = kubernetes.resource

default check = false

check {
	plugins :=  kubernetes.plugins
	some i, _ in plugins
        kubernetes.kind == "AdmissionConfiguration"
    	plugins[i].name == "EventRateLimit" 
        
}

is_admission_config {
     kubernetes.kind == "AdmissionConfiguration"
}

passed[result] {
    plugins :=  kubernetes.plugins
    is_admission_config
	some i, _ in plugins
    	plugins[i].name == "EventRateLimit"
    result := {"message" : sprintf("%s '%s' the 'EventRateLimit' is configured ", [kubernetes.kind, kubernetes.name]),"snippet" : { r | r := kubernetes.plugins[_]; r.name == "EventRateLimit" }[_]}
}

failed[result] {
    is_admission_config
    not check
    result := {"message" : sprintf("%s '%s' the 'EventRateLimit' is not configured", [kubernetes.kind, kubernetes.name]),"snippet" : {}}
}


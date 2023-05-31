# METADATA
# title: "Verify that the admission control plugin AlwaysPullImages is set"
# description: "When AlwaysPullImages is set, Kubernetes enforces a policy that requires containers to always pull the latest version of their image from the container registry before running."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#alwayspullimages
# custom:
#   id: CB_K8S_065
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_065
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

check[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	startswith(commands, "--enable-admission-plugins")
	contains(commands, "=")
	args := split(commands, "=")[1]
	contains(args, "AlwaysPullImages")
}
noAdmissionPluginAlwaysPullImages[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--enable-admission-plugins' 'AlwaysPullImages' is set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := noAdmissionPluginAlwaysPullImages[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--enable-admission-plugins' should be set to 'AlwaysPullImages'", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
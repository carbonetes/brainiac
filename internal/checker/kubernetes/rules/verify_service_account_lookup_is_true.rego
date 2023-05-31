# METADATA
# title: "Ensure that the --service-account-lookup argument is set to true"
# description: "This option is important for securing access to the Kubernetes API server and should be set to true to ensure that all requests to the API server are authenticated and authorized based on the identity of the requesting pod and service account."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#kube-apiserver
# custom:
#   id: CB_K8S_080
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_080
import data.lib.kubernetes

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


checkFailed[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	commands := container.command[_]
	contains(commands, "--service-account-lookup=false")
}

serviceLookUpTrue[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not checkFailed[container]
}

passed[result] {
	isValid
	res := serviceLookUpTrue[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--service-account-lookup' is set to true", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := checkFailed[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--service-account-lookup' should be set to true.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
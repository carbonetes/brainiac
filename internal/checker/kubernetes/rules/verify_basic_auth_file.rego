# METADATA
# title: "Verify that the --basic-auth-file argument is not set"
# description: "Do not use basic authentication. Basic authentication uses plaintext credentials for authentication."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/authentication/
# custom:
#   id: CB_K8S_055
#   severity: LOW
package lib.kubernetes.CB_K8S_055
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
	startswith(commands, "--basic-auth-file")
}
basicAuthNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := basicAuthNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--basic-auth-file' is not set", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--basic-auth-file' should not set", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
# METADATA
# title: "Verify that the --token-auth-file argument is not set"
# description: "The tokens are stored in clear-text in a file on the apiserver, and cannot be revoked or rotated without restarting the apiserver. Therefore, you should not use token-based static authentication."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/access-authn-authz/authentication/
# custom:
#   id: CB_K8S_056
#   severity: LOW
package lib.kubernetes.CB_K8S_056
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
	startswith(commands, "--token-auth-file")
}
basicAuthNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := basicAuthNotSet[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s)' for '--token-auth-file' is not set", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' 'command(s) for '--token-auth-file' should not set", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
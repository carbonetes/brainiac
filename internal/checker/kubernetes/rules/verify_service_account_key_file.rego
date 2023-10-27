# METADATA
# title: "Verify that the --service-account-key-file argument is set"
# description: "Verifying that the --service-account-key-file argument is set is an important security step in a Kubernetes cluster, as it ensures that the API server is using the correct private key file to verify the authenticity of service account tokens."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#service-account-signing-key-file
# custom:
#   id: CB_K8S_084
#   severity: MEDIUM
package lib.kubernetes.CB_K8S_084
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
	startswith(commands, "--service-account-key-file")
	contains(commands, "=")
	args := split(commands, "=")[1]
	regex.match(`^(\/?[a-zA-Z0-9_\-]+)+\.pem$`, args)
}

serviceAccountKeyInvalid[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
	isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--service-account-key-file' is set properly", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := serviceAccountKeyInvalid[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--service-account-key-file' should be set properly.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
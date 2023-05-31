# METADATA
# title: "Use secrets as files rather than secrets as environment variables."
# description: "Secrets injected as environment variables into the configuration of the container are also visible to anyone who has access to inspect the containers."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/concepts/configuration/secret/
# custom:
#   id: CB_K8S_036
#   severity: LOW
package lib.kubernetes.CB_K8S_036

import data.lib.kubernetes


resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}


check[environment]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container, "env")
	environment = container.env[_]
	kubernetes.has_attribute(environment.valueFrom, "secretKeyRef")
}
check[environment]{
	container := kubernetes.containers[_]
	kubernetes.has_attribute(container, "envFrom")
	environment = container.envFrom[_]
	kubernetes.has_attribute(environment, "secretRef")
}

noSecretsInEnv[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container, "envFrom")
}

noSecretsInEnv[container]{
	container := kubernetes.containers[_]
	not kubernetes.has_attribute(container, "env")
}
passed[result] {
	isValid
	res := noSecretsInEnv[_]
	result := {"message" : sprintf("Configuration for %s '%s' does not use secret for environment variables", [kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
	isValid
    res := check[_]
	result := {"message" : sprintf("Container(s) for %s '%s' should not set secret in environment variables", [kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}

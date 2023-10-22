package lib.kubernetes

kind = input.kind
name = input.metadata.name
metadata = input.metadata
spec = input.spec
subjects = input.subjects
automountServiceAccountToken = input.metadata.automountServiceAccountToken
namespace = input.metadata.namespace
resource = sprintf("%s.%s.%s", [kind, namespace, name])
plugins = input.plugins
apiVersion = input.apiVersion
rules = input.rules
labels = input.metadata.labels
selector = input.spec.selector
annotations = input.metadata.annotations


default namespace = "default"
default is_controller = false


is_pod {
	kind = "Pod"
}

is_cronjob {
	kind = "CronJob"
}

is_controller {
	kind = "Deployment"
}

is_controller {
	kind = "StatefulSet"
}

is_controller {
	kind = "DaemonSet"
}

is_controller {
	kind = "ReplicaSet"
}

is_controller {
	kind = "ReplicationController"
}

is_controller {
	kind = "Job"
}

is_rbac {
	kind = "Role"
}

is_rbac {
	kind = "RoleBinding"
}

is_rbac {
	kind = "ClusterRole"
}

is_rbac {
	kind = "ClusterRoleBinding"
}

is_serviceaccount {
	kind = "ServiceAccount"
}

is_service {
	kind = "Service"
}

is_ingress {
	kind = "Ingress"
}

is_psp {
    kind = "PodSecurityPolicy"
}

pod_containers(pod) := pod.spec.containers

containers[container] {
	some pod
	podTemplates[pod]
	available_containers = pod_containers(pod)
	container = available_containers[_]
}

containers[container] {
	available_containers = pod_containers(input)
	container = available_containers[_]
}

containers_commands[commands] {
	has_attribute(containers[_], "command")
	commands := containers[_].command[_]
}

containers_commands[commands] {
	has_attribute(containers[_], "args")
	commands := containers[_].args[_]
}

podTemplates[pod] {
	is_controller
	pod = input.spec.template
}
podTemplates[pod] {
	is_pod
	pod = input
}
podTemplates[pod] {
	is_cronjob
	pod = input.spec.jobTemplate.spec.template
}

volumes[volume] {
	some pod
	podTemplates[pod]
	volume = pod.spec.volumes[_]
}

filtered_rules(apiGroups, resources, verbs) := [ r |
	r := rules[_]
	r.apiGroups[_] == apiGroups[_]
	r.resources[_] == resources[_]
	r.verbs[_] == verbs[_]
]

has_container_command(key, flag, argument) {
	split({ r | r := key[_]; startswith(r, flag) }[_], "=")[1] == argument
}

has_attribute(key, value) {
  _ = key[value]
}

array_to_set(val) := { l | l := val[_] }

is_apiserver(container){
	has_attribute(container, "command")
	contains(container.command[_], "kube-apiserver")
}

is_apiserver(container){
	has_attribute(container, "args")
	contains(container.args[_], "kube-apiserver")
}
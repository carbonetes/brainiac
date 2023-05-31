# METADATA
# title: "Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate"
# description: "It is important to verify that these arguments are set appropriately because they ensure that communication between the Kubernetes API server and etcd is secure and encrypted using TLS."
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/#kube-apiserver-etcd-certfile
# custom:
#   id: CB_K8S_087
#   severity: HIGH
package lib.kubernetes.CB_K8S_087
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
	contains(container.command[_], "--etcd-certfile")
	contains(container.command[_], "--etcd-keyfile")
}

etcdCertAndKeyFileNotSet[container]{
	container := kubernetes.containers[_]
	kubernetes.is_apiserver(container)
	not check[container]
}

passed[result] {
    isValid
	res := check[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s)' '--etcd-certfile and --etcd-keyfile' is set properly", [kubernetes.name, kubernetes.kind, kubernetes.name]),
			   "snippet" : res}
}

failed[result] {
    isValid
    res := etcdCertAndKeyFileNotSet[_]
	result := {"message" : sprintf("Container %s for %s '%s' 'command(s) '--etcd-certfile and --etcd-keyfile' should be set.", [kubernetes.name, kubernetes.kind, kubernetes.name]),
				"snippet" : res}
}
package lib.kubernetes.CB_K8S_081

test_controller_manager_bind_adress_passed {
    result := passed with input as input_data(argument)
	count(result) == 1
}

test_controller_manager_bind_adress_failed {
    result := failed with input as input_data("192.168.1.1")
	count(result) == 1
}

input_data(args) := json.patch(json_data, [
    {"op": "replace", "path": "spec/containers/0/command/1", "value": concat("=", [flag, args])}
])


json_data := {
                "apiVersion": "v1",
                "kind": "Pod",
                "metadata": {
                    "creationTimestamp": null,
                    "labels": {
                    "component": "kubelet",
                    "tier": "control-plane"
                    },
                    "name": "kubelet",
                    "namespace": "kube-system"
                },
                "spec": {
                    "containers": [
                    {
                        "command": [
                        "kube-controller-manager",
                        "replaceable_data"
                        ],
                        "image": "gcr.io/google_containers/kubelet-amd64:v1.6.0",
                        "name": "gcr"
                    }
                    ]
                }
            }
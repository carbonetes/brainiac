package lib.kubernetes.CB_K8S_001

test_deployment_with_not_default_namespace {
            r := passed with input as{
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "nginx-deployment",
            "namespace": "carbonetes",
            "labels": {
            "app": "nginx"
            }
        },
        "spec": {
            "template": {
            "metadata": {
                "labels": {
                "app": "nginx"
                }
            }
            }
        }
    }

	count(r) == 1
}

test_deployment_with_default_namespace {
            r := failed with input as{
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": "nginx-deployment",
            "namespace": "default",
            "labels": {
            "app": "nginx"
            }
        },
        "spec": {
            "template": {
            "metadata": {
                "labels": {
                "app": "nginx"
                }
            }
            }
        }
    }

	count(r) == 1
}
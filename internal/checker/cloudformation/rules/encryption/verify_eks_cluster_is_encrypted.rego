package lib.cloudformation.CB_CFT_45
import future.keywords.in

resource := "AWS::EKS::Cluster"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties
    some encrypt in properties.EncryptionConfig
    "secrets" in encrypt.Resources
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some properties in pass
    result := {
        "message": "EKS cluster is encrypted.",
        "snippet": properties,
    }
}

failed[result] {
    some resources in fail
    result := {
        "message": "EKS cluster must be encrypted.",
        "snippet": resources,
    }
}

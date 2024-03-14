# METADATA
# title: "Verify EKS cluster is encrypted."
# description: "This policy enables managing sensitive data like passwords and API keys in Kubernetes using native APIs. When creating a secret resource, Kubernetes stores it in etcd encoded in base64. AWS recommends envelope encryption, encrypting a key with another key for added security. A master key stored in AWS KMS is used for data key generation and encrypting/decrypting sensitive data in Kubernetes secrets."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-eks-cluster.html
# custom:
#   id: CB_CFT_040
#   severity: LOW
package lib.cloudformation.CB_CFT_040
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

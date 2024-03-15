# METADATA
# title: "Verify secret encrypted using KMS CMK in Secret Manager"
# description: "This policy suggests using a customer-managed key instead of the default AWS-managed key aws/secretsmanager for encrypting secrets in Secrets Manager."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html
# custom:
#   id: CB_CFT_093
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_093
import future.keywords.in

resource := "AWS::SecretsManager::Secret"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties
    properties.KmsKeyId != ""
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some properties in pass
    result := {
        "message": "Secret is encrypted using KMS CMK in Secret Manager.",
        "snippet": properties,
    }
}

failed[result] {
    some resources in fail
    result := {
        "message": "Secret is not encrypted using KMS CMK in Secret Manager.",
        "snippet": resources,
    }
}

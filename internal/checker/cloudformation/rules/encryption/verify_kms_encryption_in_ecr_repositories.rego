# METADATA
# title: "Verify KMS encryption in  ECR repositories"
# description: "Ensure the implementation of Key Management Service (KMS) encryption is validated within Amazon Elastic Container Registry (ECR) repositories."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html
# custom:
#   ID: CB_CFT_097
#   Severity: LOW
package lib.cloudformation.CB_CFT_097
import future.keywords.in

resource := "AWS::ECR::Repository"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[resources] {
	is_valid
	resources := input.Resources
	count(fail) == 0
}

fail[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties.EncryptionConfiguration
    properties.EncryptionType != "KMS"
}

passed[result] {
    some properties in pass
    result := {
        "message": "ECR repositories is KMS encrypted.",
        "snippet": properties,
    }
}

failed[result] {
    some resources in fail
    result := {
        "message": "ECR repositories is not KMS encrypted.",
        "snippet": resources,
    }
}

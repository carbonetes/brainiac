# METADATA
# title: "Verify KMS encryption in  ECR repositories"
# description: "Ensure the implementation of Key Management Service (KMS) encryption is validated within Amazon Elastic Container Registry (ECR) repositories."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html
# custom:
#   id: CB_CFT_092
#   severity: LOW
package lib.cloudformation.CB_CFT_092
import future.keywords.in

resource := "AWS::ECR::Repository"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties.EncryptionConfiguration
    properties.EncryptionType == "KMS"
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
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

# METADATA
# title: "Verify KMS encryption in ECR repositories"
# description: "This policy recommends encrypting ECR repositories to prevent unauthorized access or tampering, protecting against external threats like hackers or malware, as well as internal risks such as accidental or unauthorized access."
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

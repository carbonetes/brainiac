# METADATA
# title: "Verify Lambda environment have no hard coded secrets."
# description: "This policy checks AWS Lambda functions to ensure that no hard-coded secrets are present in their environment variables."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# custom:
#   ID: CB_CFT_35
#   Severity: High
package lib.cloudformation.CB_CFT_35
import future.keywords.in

resource := "AWS::Lambda::Function"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[resources] {
    is_valid
    resources := input.Resources
    count(fail) == 0
}

fail[resources] {
    is_valid
    some resources in input.Resources
    some no_secret in resources.Properties.Environment.Variables
    no_secret == "secret"
}

passed[result] {
    some resources in input.Resources
    pass
    result := {
        "message": "S3 bucket has blocked public ACLs.",
        "snippet": resources,
    }
}

failed[result] {
    some resources in input.Resources
    not pass
    result := {
        "message": "S3 bucket should block public ACLs.",
        "snippet": resources,
    }
}

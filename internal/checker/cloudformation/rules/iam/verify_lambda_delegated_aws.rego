# METADATA
# title: "Verify AWS Lambda permissions are delegated to AWS services"
# description: "This policy ensures that permissions given to AWS Lambda functions by other AWS services are appropriately restricted by either the SourceArn or SourceAccount. This is crucial for bolstering the function's security by limiting access solely to essential AWS services. Without these restrictions, there's a risk of unauthorized or inappropriate access to the function, potentially compromising the security and confidentiality of your AWS applications and data. By confining permissions through SourceArn or SourceAccount, the policy reduces the breadth of access, thereby mitigating potential security risks."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html
# custom:
#   id: CB_CFT_121
#   severity: HIGH
package lib.cloudformation.CB_CFT_121
import future.keywords.in

resource := "AWS::Lambda::Permission"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    principal := properties.Principal
    principal != null
    principal_parts := split(principal, ".")
    count(principal_parts) >= 3
    principal_parts[1] == "amazonaws"
    principal_parts[2] == "com"
    "SourceAccount" in object.keys(properties)
    "SourceArn" in object.keys(properties)
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}


passed[result] {
    some block in pass
    result := {
        "message": "AWS Lambda function permissions are limited by SourceArn or SourceAccount",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "AWS Lambda function permissions are not limited by SourceArn or SourceAccount",
        "snippet": block,
    }
}
